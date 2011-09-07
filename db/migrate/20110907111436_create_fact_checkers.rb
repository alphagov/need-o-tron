class CreateFactCheckers < ActiveRecord::Migration
  def change
    create_table :fact_checkers do |t|
      t.integer :contact_id, :need_id

      t.timestamps
    end
    rename_table :fact_checking_contacts, :contacts
  end
end
