class NeedSearch
  attr_accessor :es_response, :query, :facet_by, :filters

  def initialize(query, options = {})
    @query = query
    @facet_by = options[:facet_by] || []
    @filters = options[:filters] || {}
    @per_page = options[:per_page] || 10
    @start = options[:start] || 0
    @page = options[:page] || 1
    @sort = options[:sort] || []
  end

  class Error < RuntimeError; end
  class NotYetExecuted < RuntimeError; end

  def execute
    sort_params = [*@sort].map do |param, direction| 
      { param.to_sym => direction.to_sym }
    end.flatten

    search = Tire.search 'needs' do |search|
      if @query.present?
        search.query do |query|
          query.string @query
        end
      end

      search.size   @per_page
      search.from   (@page - 1) * @per_page

      if @filters.any?
        @filters.each do |field, values|
          search.filter :terms, field.to_sym => values
        end
      end

      # TODO: We're defining our list of facets in two places, here and
      # in the controller. That's not so good.
      search.facet 'priority' do
        terms :priority
      end

      search.facet 'writing_dept' do
        terms :writing_department
      end

      search.facet 'status' do
        terms :status
      end

      search.facet 'kind' do
        terms :kind
      end

      search.facet 'tag' do
        terms :tags
      end
    end

    @es_response = search.results
  end

  def response
    raise NotYetExecuted unless @es_response
    @es_response
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
    response.present? && response.facets
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