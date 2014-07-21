class User < ActiveRecord::Base
  include GDS::SSO::User

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :uid

  serialize :permissions, Array

  def to_s
    email
  end

  def is_admin?
    has_permission?("admin")
  end
end
