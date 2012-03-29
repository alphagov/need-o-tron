class SolrIndexer
  def initialize(client, need)
    @client = client
    @need = need
  end

  def execute
    @client.update!(@need.to_solr_document, commitWithin: 5.minutes * 1000)
    @client.commit!
  end

  def delete
    @client.delete(@need.id)
    @client.commit!
  end
end