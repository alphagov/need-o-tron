class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :uid, :version

  def self.find_for_gds_oauth(auth_hash)
    if user = User.find_by_email(auth_hash["uid"])
      user
    else # Create a user with a stub password. 
      user_params = auth_hash.dup.keep_if { |k,v| ['uid', 'email', 'name', 'version'].include?(k) }
      puts "PARAMS: #{user_params.inspect}"
      puts "AUTH_HASH: #{auth_hash.inspect}"
      User.create!(user_params) 
    end
  end

  def to_s
    email
  end
end
