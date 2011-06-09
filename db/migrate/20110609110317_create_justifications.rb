class CreateJustifications < ActiveRecord::Migration
  def change
    create_table :justifications do |t|
      t.string :kind
      t.text :details
      t.belongs_to :need

      t.timestamps
    end
    add_index :justifications, :need_id
  end
end
