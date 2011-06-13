class ExistingService < ActiveRecord::Base
  validate :description, :presence => true
  
  belongs_to :need
end
