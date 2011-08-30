class MakeDeviseInvitable < ActiveRecord::Migration
  def change
    # Another no-op since we removed Devise
    change_table :users do |t|
    end
  end
end
