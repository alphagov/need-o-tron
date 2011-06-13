class AddEvidenceFileToJustification < ActiveRecord::Migration
  def change
    add_column :justifications, :file, :string
  end
end