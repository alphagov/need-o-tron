class Need < ActiveRecord::Base
  belongs_to :kind
  has_and_belongs_to_many :departments
  has_many :justifications
  
  accepts_nested_attributes_for :justifications, :reject_if => :all_blank
  acts_as_taggable
end
