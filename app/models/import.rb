require 'active_model/naming'
require 'set'

class Import
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  IMPORT_OPTIONS = [:priority, :fact_checker, :accountability]

  attr_reader :opts
  attr_reader :errors

  def initialize(opts = {})
    @opts = opts.symbolize_keys
    @errors = ActiveModel::Errors.new(self)
  end

  def persisted?
    false
  end

  def valid?
    true
  end

  def to_param
    nil
  end

  IMPORT_OPTIONS.each { |method_name| attr_reader method_name }

  def import_keys
    @base_import_keys ||= Set.new(IMPORT_OPTIONS)
    (@base_import_keys & opts.keys).select { |key| opts[key] == "1" }
  end

  def id_from_row(row)
    row['Id'] || row['ID']
  end

  def save
    CSV.open(opts[:csv].open, :headers => true) do |csv|
      csv.each do |row|
        if id_from_row(row)
          need = Need.find_by_id(id_from_row(row))
          if need
            import_keys.each do |key|
              Updaters.send(key, need, row)
            end
            need.save if need.changed?
          end
        end
      end
    end
  end

  module Updaters
    def self.priority(need, row)
      need.priority = row['Priority'] if row['Priority']
    end

    def self.calculate_changes(current, updates)
     current = Set.new(current)
     updates = Set.new(updates)
     to_add = updates - current
     to_remove = current - updates
     [to_add, to_remove]
    end

    def self.extract_list(cell, separator = ',')
      cell.split(separator).collect { |item| item.strip }
    end

    def self.fact_checker_changes(current_checkers, updates)
      calculate_changes(current_checkers, updates)
    end

    def self.extract_fact_checkers(csv_cell)
      extract_list(csv_cell)
    end

    def self.fact_checker(need, row)
      if row['Fact checker']
        updates = extract_fact_checkers(row['Fact checker'])
        current = need.current_fact_checker_emails
        fact_checkers_to_create, fact_checkers_to_delete = fact_checker_changes(current, updates)

        fact_checkers_to_create.each { |email| need.add_fact_checker_with_email(email) }
        fact_checkers_to_delete.each { |email| need.remove_fact_checker_with_email(email) }
      end
    end

    def self.accountability_changes(current_accountabilities, updates)
      calculate_changes(current_accountabilities, updates)
    end

    def self.extract_accountabilities(csv_cell)
      extract_list(csv_cell)
    end

    def self.accountability(need, row)
      if row['Accountability']
        updates = extract_accountabilities(row['Accountability'])
        current = need.current_accountability_names
        accountabilities_to_create, accountabilities_to_delete = accountability_changes(current, updates)

        accountabilities_to_create.each { |name| need.add_accountability_with_name(name) }
        accountabilities_to_delete.each { |name| need.remove_accountability_with_name(name) }
      end
    end
  end
end
