class AddFormattingDecisionToNeed < ActiveRecord::Migration
  def change
    add_column :needs, :formatting_decision_maker_id, :integer
    add_column :needs, :formatting_decision_made_at, :datetime
    add_column :needs, :reason_for_formatting_decision, :text
  end
end
