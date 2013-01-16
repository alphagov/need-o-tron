require 'ostruct'
class NeedSearch
  attr_accessor :response, :query, :facet_by, :filters

  def initialize(query, options = {})
    @query = query
    @facet_by = options[:facet_by] || []
    @filters = options[:filters] || {}
    @per_page = options[:per_page] || 10
    @start = options[:start] || 0
    @page = options[:page] || 0
    @sort = options[:sort] || []
  end

  class Error < RuntimeError; end

  def execute
    @response = Need.search(:page => @page, :per_page => @per_page) do
      # query             { @query.present? ? "all:#{@query}" : "*:*" }
      # facet('timeline') { date   :published_on, :interval => 'month' }
      sort                { by [*@sort].map { |param, direction| { param.to_sym => direction.to_sym } } }
    end
    # params = {
    #   query: ,
    #   filters: filters,
    #   facets: @facet_by.map { |facet| {field: facet, mincount: 1} },
    #   fields: "*",
    #   start: @start,
    #   rows: @per_page
    # }
    # params[:sort] = [*@sort].join(',') if @sort.present?
    # self.response = client.query 'standard', params
    # if ! self.response
    #   raise NeedSearch::Error, "Unable to search, maybe the search server is down.", caller
    # end
  end

  def pages
    1..last_page
  end

  def last_page
    (count / @per_page.to_f).ceil
  end

  def nothing_found?
    response.blank?
  end

  def count
    response.total
  end

  def results
    response
  end

  def facets
    return Hash.new { [] }
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