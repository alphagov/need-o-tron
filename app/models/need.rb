class Need < ActiveRecord::Base
  belongs_to :kind
  has_and_belongs_to_many :departments
  has_many :justifications
  
  acts_as_taggable
end
