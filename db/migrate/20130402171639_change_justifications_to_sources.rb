class ChangeJustificationsToSources < ActiveRecord::Migration
  def up
    Justification.all.each do |item|
      Source.create!(
        :title => nil,
        :url => nil,
        :kind => item.evidence_type.present? ? item.evidence_type.name.parameterize.gsub('-','_').sub('govt','government') : 'existing_service',
        :body => item.details,
        :need_id => item.need_id
      )
      item.destroy
    end
  end

  def down
    kinds = Hash[EvidenceType.all.map {|e| [e.id, e.name.parameterize.gsub('-','_').sub('govt','government')] }]

    Source.where(:kind => kinds.values).all.each do |source|
      Justification.create!(
        :details => source.body,
        :evidence_type_id => kinds.key(source.kind),
        :need_id => source.need_id
      )
      source.destroy
    end
  end
end
