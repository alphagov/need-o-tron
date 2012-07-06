class DropObsoleteUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :is_admin
    remove_column :users, :version
  end
end
