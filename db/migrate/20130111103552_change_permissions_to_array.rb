class ChangePermissionsToArray < ActiveRecord::Migration
  class User < ActiveRecord::Base
    serialize :permissions
  end

  def up
    User.all.each do |user|
      if user.permissions.is_a?(Hash)
        user.permissions = user.permissions["Need-o-Tron"]
        user.save!
      end
    end
  end

  def down
    User.all.each do |user|
      unless user.permissions.nil?
        user.permissions = { "Need-o-Tron" => user.permissions }
        user.save!
      end
    end
  end
end
