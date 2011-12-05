class DenormalizeFactCheckers < ActiveRecord::Migration
  def change
    add_column :fact_checkers, :email, :string
  end
end