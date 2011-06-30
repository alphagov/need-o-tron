require 'csv_renderer'
require 'csv'

class NeedsCsv < CsvRenderer
  def to_csv
    CSV.generate do |csv|
      csv << ["Id", "Title", "Context", "Tags", "Status", "Audiences", "Updated at"]
      @data.each do |need|
        csv << [need.id, need.title, need.description, need.tag_list, need.status, need.audiences.collect { |a| a.name }.join(", "), need.updated_at.to_formatted_s(:db)]
      end
    end
  end

  def csv_filename(params)
    "needs-#{params['in_state']}-#{@timestamp.to_formatted_s(:filename_timestamp)}.csv"
  end
end