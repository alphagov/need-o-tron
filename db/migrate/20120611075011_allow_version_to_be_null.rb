class AllowVersionToBeNull < ActiveRecord::Migration
  def up
    change_column :users, :version, :integer
  end

  def down
    change_column :users, :version, :integer, null: false
  end
end
