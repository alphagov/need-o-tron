class Audience < ActiveRecord::Base
  validate :name, :presence => true
  
  has_and_belongs_to_many :needs
end
