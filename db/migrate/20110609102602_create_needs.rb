class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.string :title
      t.text :description
      t.belongs_to :kind
      t.string :status
      t.string :url
      t.integer :priority
      t.integer :creator_id
      t.text :notes

      t.timestamps
    end
    add_index :needs, :kind_id
  end
end
