class NeedSearch
  include ::Pethau::InitializeWith
  initialize_with :query

  class Error < RuntimeError
  end
  
  def execute
    params = {
      :query => query.present? ? "all:#{query}" : "*:*",
      :fields => "*",
      :filters => []
    }
    response = client.query 'standard', params
    raise NeedSearch::Error, "Unable to search, maybe the search server is down.", context if ! response
    response.docs
  end

  def client
    $solr
  end
end