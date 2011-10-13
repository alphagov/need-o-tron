require 'spec_helper'
require 'delsolr'
require 'solr_indexer'

describe SolrIndexer do
  it 'instructs solr to index a simple need' do
    need = stub_everything 'Need'
    document = stub_everything 'Document'
    need.stubs(:to_solr_document).returns document

    solr_client = stub_everything
    solr_client.expects(:update!).with(document, :commitWithin => 5.minutes*1000)
    
    indexer = SolrIndexer.new(solr_client, need)
    indexer.execute
  end
end

describe SolrNeedPresenter do
  it 'generates a document containing the indexed attributes' do
    need = stub_everything
    need.stubs(
      id: 123,
      title: "Replace your passport",
      description: "This is the description",
      priority: 3,
      kind: stub(name: 'example'),
      creator: stub(name: "Bob", email: 'bob@example.com'),
      notes: "These are the notes",
      decision_maker: stub(name: "Big Cheese", email: 'big.cheese@example.com'),
      created_at: Time.at(4),
      updated_at: Time.at(5),
      decision_made_at: Time.at(6),
      reason_for_decision: "Just because",
      tag_list: "red,blue",
      search_rank: 3,
      pairwise_rank: 4,
      traffic: 5,
      usage_volume: 6,
      interaction: 7,
      related_needs: "Get a new passport",
      statutory: true,
      formatting_decision_maker: stub(name: "Mary", email: "mary@example.com"),
      formatting_decision_made_at: Time.at(7),
      reason_for_formatting_decision: "Another reason"
    )
    expected_document = DelSolr::Document.new.tap do |doc|
      # Full text indexed fields
      doc.add_field "id", need.id
      doc.add_field "title", need.title
      doc.add_field "description", need.description
      doc.add_field "notes", need.notes
      doc.add_field "reason_for_decision", need.reason_for_decision
      doc.add_field "reason_for_formatting_decision", need.reason_for_formatting_decision
      doc.add_field "writing_dept", need.writing_dept
      doc.add_field "tag", "red"
      doc.add_field "tag", "blue"

      # Faceted fields
      doc.add_field "kind", need.kind.name
      doc.add_field "status", need.status
      doc.add_field "priority", need.priority

      # Sorting fields
      doc.add_field "created_at", need.created_at.to_s
      doc.add_field "updated_at", need.updated_at.to_s
      doc.add_field "decision_made_at", need.decision_made_at
      doc.add_field "formatting_decision_made_at", need.formatting_decision_made_at.to_s
      
      doc.add_field "rails_env", Rails.env
    end
    assert_equal expected_document.xml, SolrNeedPresenter.new(need).to_solr_document.xml
  end
end