class User < ActiveRecord::Base  
  include GDS::SSO::User

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :uid
  attr_accessible :uid, :email, :name, :permissions, as: :oauth

  serialize :permissions, Array

  def to_s
    email
  end

  def is_admin?
    has_permission?(GDS::SSO::Config.default_scope, "admin")
  end
end
