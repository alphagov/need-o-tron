class Need < ActiveRecord::Base
  
  FORMAT_ASSIGNED = "format-assigned"
  READY_FOR_REVIEW = "ready-for-review"
  BIN = "bin"
  NEW = "new"
  DONE = "done"

  STATUSES = [NEW, READY_FOR_REVIEW, FORMAT_ASSIGNED, DONE, BIN]
  PRIORITIES_FOR_SELECT = [['low', 1], ['medium', 2], ['high', 3]]
  PRIORITIES = {1 => 'low', 2 => 'medium', 3 => 'high'}

  belongs_to :kind
  belongs_to :decision_maker, :class_name => 'User'
  belongs_to :formatting_decision_maker, :class_name => 'User'
  belongs_to :creator, :class_name => 'User'
  
  has_many :justifications
  has_many :existing_services
  has_many :directgov_links
  
  scope :undecided, where(:decision_made_at => nil)
  scope :decided, where('decision_made_at IS NOT NULL')
  scope :in_state, proc { |s| where(:status => s) }
  default_scope order('priority, title')

  accepts_nested_attributes_for :justifications, :reject_if => :all_blank
  # acts_as_taggable

  before_save :record_decision_info, :if => :reason_for_decision_changed?
  before_save :record_formatting_decision_info, :if => :reason_for_formatting_decision_changed?
  before_save :set_creator, :on => :create

  validate :status, :in => STATUSES
  validates_presence_of :priority, :if => proc { |a| a.status == FORMAT_ASSIGNED }
  validates_presence_of :url, :if => proc { |a| a.status == 'done' }

  # validates_presence_of :reason_for_decision, :if => proc { |a| a.status == FORMAT_ASSIGNED || a.status == BIN }
  # validate :has_evidence_or_precendence, :if => proc { |a| a.status == READY_FOR_REVIEW }
  #
  # def has_evidence_or_precendence
  #   unless existing_services.count > 0 or justifications.count > 0
  #     errors[:base] << "You must include evidence or an existing service to submit a need for review"
  #   end
  # end

  def set_creator
    self.creator_id = Thread.current[:current_user]
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

  def format_assigned?
    [FORMAT_ASSIGNED, DONE, BIN].include?(status)
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
end
