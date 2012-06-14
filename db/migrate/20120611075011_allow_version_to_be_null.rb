class AllowVersionToBeNull < ActiveRecord::Migration
  def up
    change_column :users, :version, :integer, null: true
  end

  def down
    change_column :users, :version, :integer, null: false
  end
end
