class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.timestamps
    end
    create_table :departments_needs, :force => true, :primary_key => false do |t|
      t.integer :department_id, :need_id
    end
  end
end