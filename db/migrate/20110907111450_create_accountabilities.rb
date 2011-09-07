class CreateAccountabilities < ActiveRecord::Migration
  def change
    create_table :accountabilities do |t|
      t.integer :department_id, :need_id

      t.timestamps
    end
  end
end
