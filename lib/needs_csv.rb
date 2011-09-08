require 'csv_renderer'
require 'csv'

class NeedsCsv < CsvRenderer
  def to_csv
    CSV.generate do |csv|
      csv << ["Id", "Priority", "Title", "Format", "Tags", "Context", "Status", "Updated at", "Statutory", "Fact checker", "Interaction", "Related needs"]
      @data.each do |need|
        csv << [need.id, need.named_priority, need.title, need.kind.to_s, need.tag_list, need.description, need.status, need.updated_at.to_formatted_s(:db), 
          need.statutory, need.fact_checkers_for_csv, need.interaction, need.related_needs]
      end
    end
  end

  def csv_filename(params)
    "needs-#{params['in_state']}-#{@timestamp.to_formatted_s(:filename_timestamp)}.csv"
  end
end
