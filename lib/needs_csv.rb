require 'csv_renderer'
require 'csv'

class NeedsCsv < CsvRenderer
  def fact_checkers(need)
    need.current_fact_checker_emails.join(', ')
  end

  def accountabilities(need)
    need.current_accountability_names.join(', ')
  end

  def to_csv
    CSV.generate do |csv|
      csv << ["Id", "Lead department", "Priority", "Title", "Format", "Tags", "Context", "Status", "Updated at", "Statutory", "Fact checker", "Writing dept", "Interaction", "Related needs", "Reason for formatting decision", "Reason for decision", "DG Links", "Existing Services"]
      @data.each do |need|
        csv << [need.id, accountabilities(need), need.named_priority, need.title, need.kind.to_s, need.tag_list,
                need.description, need.status, need.updated_at.to_formatted_s(:db),
                need.statutory, fact_checkers(need), need.writing_department.to_s,
                need.interaction, need.related_needs, need.reason_for_formatting_decision,
                need.reason_for_decision, need.directgov_links.collect(&:directgov_id).join(','),
                need.existing_services.collect(&:link).join(',')
              ]
      end
    end
  end

  def csv_filename(params)
    "needs-#{params['in_state']}-#{@timestamp.to_formatted_s(:filename_timestamp)}.csv"
  end
end
