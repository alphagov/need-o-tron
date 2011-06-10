class MakeDeviseInvitable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.invitable
    end
  end
end