class CreateEvidenceTypes < ActiveRecord::Migration
  def change
    create_table :evidence_types do |t|
      t.string :name
      t.integer :weight
      t.string :type

      t.timestamps
    end

    add_column :justifications, :evidence_type_id, :integer

    Justification.find_each do |j|
      if j.kind.present?
        j.evidence_type = EvidenceType.find_or_create_by_name(j.kind)
        j.save
      end
    end

    remove_column :justifications, :kind
  end
end