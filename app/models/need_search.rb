require 'ostruct'
class NeedSearch
  attr_accessor :response, :query, :facet_by, :filters

  def initialize(query, options = {})
    @query = query
    @facet_by = options[:facet_by] || []
    @filters = options[:filters] || {}
  end
  
  class Error < RuntimeError; end

  def execute
    params = {
      query: @query.present? ? "all:#{@query}" : "*:*",
      filters: filters,
      facets: @facet_by.map { |facet| {field: facet} },
      fields: "*",
    }
    self.response = client.query 'standard', params
    if ! self.response
      raise NeedSearch::Error, "Unable to search, maybe the search server is down.", context
    end
  end

  def nothing_found?
    response.blank?
  end

  def results
    response.docs.map { |doc|
      OpenStruct.new doc
    }
  end

  def facets
    response.present? && response.facet_fields
  end
  
  def each_result &block
    results.each &block
  end

  def client
    $solr
  end
  
  def filters
    Hash[
      @filters.map do |field, values|
        [field, [*values].map {|value| value.blank? ? nil : value}]
      end
    ].merge(rails_env_filter)
  end
  
  def rails_env_filter
    { rails_env: Rails.env }
  end
end