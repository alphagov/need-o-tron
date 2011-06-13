class AddDecisionToNeed < ActiveRecord::Migration
  def change
    add_column :needs, :decision_maker_id, :integer
    add_column :needs, :decision_made_at, :datetime
    add_column :needs, :reason_for_decision, :text
  end
  
  create_table :audiences_needs, :force => true, :id => false do |t|
    t.integer :audience_id, :need_id
  end
end