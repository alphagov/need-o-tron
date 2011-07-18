class AddStatutoryFieldToNeeds < ActiveRecord::Migration
  def change
    add_column :needs, :statutory, :boolean
  end
end