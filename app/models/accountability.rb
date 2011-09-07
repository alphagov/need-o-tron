class Accountability < ActiveRecord::Base
  belongs_to :department
  belongs_to :need
end
