class SplitDepartments < ActiveRecord::Migration
  def up 
    rename_table :departments, :writing_departments
    create_table :departments do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :departments             
    rename_table :writing_departments, :departments
  end
end
