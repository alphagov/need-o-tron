class Department < ActiveRecord::Base
  has_and_belongs_to_many :needs
  default_scope order('name')
end
