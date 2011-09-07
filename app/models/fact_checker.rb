class FactChecker < ActiveRecord::Base
  belongs_to :contact
  belongs_to :need
end
