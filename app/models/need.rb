class Need < ActiveRecord::Base
  class_attribute :index_command

  class CannotDeleteStartedNeed < Exception; end

  MAXIMUM_POLICY_DEPARTMENTS = 5
  MAXIMUM_FACT_CHECKERS = 5

  FORMAT_ASSIGNED = "format-assigned"
  READY_FOR_REVIEW = "ready-for-review"
  IN_PROGRESS = "in-progress"
  ICEBOX = "icebox"
  NEW = "new"
  DONE = "done"

  STATUSES = [NEW, READY_FOR_REVIEW, FORMAT_ASSIGNED, IN_PROGRESS, DONE, ICEBOX]
  PRIORITIES_FOR_SELECT = [['low', 1], ['medium', 2], ['high', 3]]
  PRIORITIES = {1 => 'low', 2 => 'medium', 3 => 'high'}

  belongs_to :kind
  belongs_to :decision_maker, :class_name => 'User'
  belongs_to :formatting_decision_maker, :class_name => 'User'
  belongs_to :creator, :class_name => 'User'

  has_many :justifications
  has_many :existing_services
  has_many :directgov_links
  has_many :fact_checkers

  belongs_to :writing_department

  has_many :accountabilities
  has_many :policy_departments, :through => :accountabilities, :source => :department

  accepts_nested_attributes_for :accountabilities, :reject_if => :all_blank
  accepts_nested_attributes_for :fact_checkers, :reject_if => :all_blank

  scope :undecided, where(:decision_made_at => nil)
  scope :decided, where('decision_made_at IS NOT NULL')
  scope :in_state, proc { |s| where(:status => s).includes([:fact_checkers, :accountabilities, :creator, :kind, :directgov_links, :existing_services, :justifications, :writing_department]) }
  default_scope order('priority, title')

  accepts_nested_attributes_for :justifications, :reject_if => :all_blank

  before_save :record_decision_info, :if => :reason_for_decision_changed?
  before_save :record_formatting_decision_info, :if => :reason_for_formatting_decision_changed?
  before_save :set_creator, :on => :create
  before_validation :delete_empty_fact_checkers, :delete_empty_accountabilities
  after_save :update_search_index

  before_destroy :check_need_is_not_started

  validate :status, :in => STATUSES
  validates_presence_of :priority, :if => proc { |a| a.status == FORMAT_ASSIGNED }
  validates_presence_of :url, :if => proc { |a| a.status == 'done' }

  def set_creator
    self.creator = Thread.current[:current_user]
  end

  attr_writer :indexer

  def indexer
    @indexer ||= SolrIndexer
  end

  def update_search_index
    indexable = SolrNeedPresenter.new(self)
    indexer.new($solr, indexable).execute
  end

  def self.index_all
    Need.find_each do |need|
      need.update_search_index
    end
  end

  def record_decision_info
    if self.decision_made_at.nil? and self.reason_for_decision.present?
      self.decision_made_at = Time.now
      self.decision_maker = Thread.current[:current_user]
    end
  end

  def record_formatting_decision_info
    if self.formatting_decision_made_at.nil? and self.reason_for_formatting_decision.present?
      self.formatting_decision_made_at = Time.now
      self.formatting_decision_maker = Thread.current[:current_user]
    end
  end

  def delete_empty_accountabilities
    accountabilities.each do |ac|
      ac.mark_for_destruction if ac.department_id.blank?
    end
  end

  def delete_empty_fact_checkers
    fact_checkers.each do |fc|
      fc.mark_for_destruction if fc.email.blank?
    end
  end

  def format_assigned?
    [FORMAT_ASSIGNED, IN_PROGRESS, DONE, ICEBOX].include?(status)
  end

  def being_worked_on?
    [FORMAT_ASSIGNED, IN_PROGRESS, DONE].include?(status)
  end

  def in_progress?
    [IN_PROGRESS, DONE].include?(status)
  end

  STATUSES.each do |status_label|
    define_method "#{status_label}?" do
      status == status_label
    end
  end

  def decision_made?
    decision_made_at.present?
  end

  def formatting_decision_made?
    formatting_decision_made_at.present?
  end

  def prioritised?
    !priority.nil?
  end

  def named_priority
    PRIORITIES[priority]
  end

  def priority=(name_or_value)
    if PRIORITIES.keys.include?(name_or_value)
      write_attribute(:priority, name_or_value)
      return name_or_value
    end
    PRIORITIES_FOR_SELECT.each do |name, value|
      if value.to_s == name_or_value
        write_attribute(:priority, value)
        return value
      end
      if name_or_value[0] == name[0]
        write_attribute(:priority, value)
        return named_priority
      end
    end
    nil
  end

  def current_fact_checker_emails
    fact_checkers.collect { |f| f.email }
  end

  def add_fact_checker_with_email(email)
    fact_checkers.build(contact: Contact.find_or_initialize_by_email(email))
  end

  def remove_fact_checker_with_email(email)
    fact_checkers.select { |fc| fc.contact.email == email }.each do |fc|
      fact_checkers.destroy(fc)
    end
  end

  def current_accountability_names
    accountabilities.collect { |a| a.department.name }
  end

  def add_accountability_with_name(name)
    accountabilities.build(department: Department.find_or_initialize_by_name(name))
  end

  def remove_accountability_with_name(name)
    accountabilities.select { |a| a.department.name == name }.each do |a|
      accountabilities.destroy(a)
    end
  end

  def check_need_is_not_started
    raise(CannotDeleteStartedNeed.new) if in_progress?
  end
end
