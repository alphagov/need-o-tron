class Department < ActiveRecord::Base
  has_many :accountabilities
end
