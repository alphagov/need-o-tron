class Need < ActiveRecord::Base
  STATUSES = ['new', 'ready-for-review', 'ready-for-carding', 'done', 'bin']
  
  belongs_to :kind
  belongs_to :decision_maker, :class_name => 'User'
  belongs_to :creator, :class_name => 'User'
  
  has_and_belongs_to_many :departments
  has_and_belongs_to_many :audiences
  has_many :justifications
  has_many :existing_services
  
  scope :undecided, where(:decision_made_at => nil)
  scope :decided, where('decision_made_at IS NOT NULL')
  scope :in_state, proc { |s| where(:status => s) }
  
  accepts_nested_attributes_for :justifications, :reject_if => :all_blank
  acts_as_taggable
  
  before_save :record_decision_info, :if => :reason_for_decision_changed?
  before_save :set_creator, :on => :create
  
  validate :status, :in => STATUSES
  
  def set_creator
    creator_id = Thread.current[:current_user]
  end
  
  def record_decision_info
    if self.decision_made_at.nil? and self.reason_for_decision.present?
      self.decision_made_at = Time.now
      self.decision_maker = Thread.current[:current_user]
    end
  end
  
  def decision_made?
    decision_made_at.present?
  end
end
