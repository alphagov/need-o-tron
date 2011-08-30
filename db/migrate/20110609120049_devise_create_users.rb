class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    # Essentially a no-op now since we've dropped Devise and don't want to screw
    # up existing deployments
    create_table(:users) do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
