class AddDecisionToNeed < ActiveRecord::Migration
  def change
    add_column :needs, :decision_maker_id, :integer
    add_column :needs, :decision_made_at, :datetime
    add_column :needs, :reason_for_decision, :text
  end
end