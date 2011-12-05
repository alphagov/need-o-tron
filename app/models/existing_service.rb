class ExistingService < ActiveRecord::Base
  validates :description, :presence => true

  belongs_to :need
end
