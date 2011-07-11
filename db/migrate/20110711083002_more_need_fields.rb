class MoreNeedFields < ActiveRecord::Migration
  def change
    change_table :needs do |t|
      t.integer :search_rank, :pairwise_rank, :traffic, :usage_volume, :interaction
      t.string :related_needs
    end
  end
end