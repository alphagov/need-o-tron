class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :title
      t.string :url
      t.string :kind
      t.text :body
      t.references :need

      t.timestamps
    end
  end
end
