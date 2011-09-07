class RemoveHabtmTablesForFactCheckersAndDepartments < ActiveRecord::Migration
  def change
    drop_table :departments_needs, :facting_checking_contacts_needs
  end
end
