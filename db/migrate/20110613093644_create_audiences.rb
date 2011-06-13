class CreateAudiences < ActiveRecord::Migration
  def change
    create_table :audiences do |t|
      t.string :name

      t.timestamps
    end
  end
end
