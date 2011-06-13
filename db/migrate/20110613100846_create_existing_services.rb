class CreateExistingServices < ActiveRecord::Migration
  def change
    create_table :existing_services do |t|
      t.text :description
      t.text :link
      t.boolean :government_run
      t.string :kind
      t.belongs_to :need
      t.timestamps
    end
  end
end
