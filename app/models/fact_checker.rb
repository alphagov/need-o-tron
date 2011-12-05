class FactChecker < ActiveRecord::Base
  belongs_to :need
  belongs_to :contact

  validates :email, :presence => true
end
