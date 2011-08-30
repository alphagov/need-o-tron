class CreateDirectgovLink < ActiveRecord::Migration
  def change
    create_table :directgov_links do |t|
      t.text :title
      t.string :directgov_id, :null => false
      t.belongs_to :need
      t.boolean :found, :default => false
      t.timestamps
    end
  end
end
