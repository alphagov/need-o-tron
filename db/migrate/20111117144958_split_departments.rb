class SplitDepartments < ActiveRecord::Migration
  def up
    create_table :writing_departments do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :writing_departments
  end
end
