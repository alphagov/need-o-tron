class AddTagListToNeed < ActiveRecord::Migration
  def change
    add_column :needs, :tag_list, :text
  end
end