require 'active_model/naming'

class Import
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :opts
  attr_reader   :errors

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

  def save
    CSV.open(opts[:csv].open, :headers => true) do |csv|
      csv.each do |row|
        if row['Id'] && row['Priority']
          need = Need.find_by_id(row['Id'])
          if need
            need.priority = row['Priority']
            need.save if need.changed?
          end
        end
      end
    end
  end
end
