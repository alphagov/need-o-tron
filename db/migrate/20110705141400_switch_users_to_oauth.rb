class SwitchUsersToOauth < ActiveRecord::Migration
  def up
    drop_table :users
    create_table :users do |t|
      t.string   :name, :null => false
      t.string   :uid, :null => false
      t.integer  :version, :null => false
      t.string   :email, :null => false
    end
  end

  def down
    raise IrreversibleMigration
  end
end
