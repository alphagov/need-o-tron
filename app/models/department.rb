class Department < ActiveRecord::Base
  has_many :accountabilities

  def to_s
    name
  end
end
