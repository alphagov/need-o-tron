class User < ActiveRecord::Base  
  include GDS::SSO::User

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :uid, :version
  attr_accessible :uid, :email, :name, :permissions, as: :oauth

  serialize :permissions, Hash

  def to_s
    email
  end
end
