class CreateFactCheckingContacts < ActiveRecord::Migration
  def change
    create_table :fact_checking_contacts do |t|
      t.string :email, :null => false
      t.timestamps
    end
    create_table :fact_checking_contacts_needs, :force => true, :id => false do |t|
      t.integer :fact_checking_contact_id, :need_id
      t.timestamps
    end
  end
end
