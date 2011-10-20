class SolrNeedPresenter
  def initialize(need)
    @need = need
  end
  
  def to_solr_document
    DelSolr::Document.new.tap do |doc|
      # Full text indexed fields
      %w{id title description notes reason_for_decision
        reason_for_formatting_decision}.each do |field|
        doc.add_field field, @need.send(field.to_sym)
      end
      @need.tag_list.to_s.split(/ *, */).each do |tag|
        doc.add_field "tag", tag
      end

      # Faceted fields
      doc.add_field "kind", @need.kind.name if @need.kind
      doc.add_field "status", @need.status
      doc.add_field "priority", @need.priority
      doc.add_field "writing_dept", @need.writing_department.name if @need.writing_department

      # Sorting fields
      %w{created_at updated_at decision_made_at formatting_decision_made_at}.each do |date_field|
        date = @need.send(date_field.to_sym)
        doc.add_field date_field, date.to_s if date
      end
      
      # Facilitate clearing test data
      doc.add_field "rails_env", Rails.env

      # Very basic logging
      puts "Adding solr document #{@need.id}:#{@need.title}"
    end
  end
end