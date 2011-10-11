class SolrNeedPresenter
  def initialize(need)
    @need = need
  end
  
  def to_solr_document
    DelSolr::Document.new.tap do |doc|
      doc.add_field "id", @need.id
      doc.add_field "title", @need.title
      doc.add_field "description", @need.description
      doc.add_field "kind", @need.kind.name if @need.kind
      doc.add_field "status", @need.status
      # doc.add_field "priority", @need.priority
      # doc.add_field "creator_name", @need.creator.name if @need.creator
      # doc.add_field "creator_email", @need.creator.email if @need.creator
      # doc.add_field "notes", @need.notes
      # doc.add_field "created_at", @need.created_at.to_s
      # doc.add_field "updated_at", @need.updated_at.to_s if @need.updated_at
      # doc.add_field "decision_maker_name", @need.decision_maker.name if @need.decision_maker
      # doc.add_field "decision_maker_email", @need.decision_maker.email if @need.decision_maker
      # doc.add_field "decision_made_at", @need.decision_made_at
      # doc.add_field "reason_for_decision", @need.reason_for_decision
      # @need.tag_list.to_s.split(",").each do |tag|
      #   doc.add_field "tag", tag
      # end
      # doc.add_field "search_rank", @need.search_rank
      # doc.add_field "pairwise_rank", @need.pairwise_rank
      # doc.add_field "traffic", @need.traffic
      # doc.add_field "usage_volume", @need.usage_volume
      # doc.add_field "interaction", @need.interaction
      # doc.add_field "related_needs", @need.related_needs
      # doc.add_field "statutory", @need.statutory
      # doc.add_field "formatting_decision_maker_name", @need.formatting_decision_maker.name if @need.formatting_decision_maker
      # doc.add_field "formatting_decision_maker_email", @need.formatting_decision_maker.email if @need.formatting_decision_maker
      # doc.add_field "formatting_decision_made_at", @need.formatting_decision_made_at.to_s if @need.formatting_decision_made_at
      # doc.add_field "reason_for_formatting_decision", @need.reason_for_formatting_decision
      # doc.add_field "writing_dept", @need.writing_dept
    end
  end
end