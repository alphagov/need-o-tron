class NeedSearch
  attr_accessor :es_response, :query, :facet_by, :filters

  def initialize(query, options = {})
    @query = query.present? ? query : '*'
    @facet_by = options[:facet_by] || []
    @filters = options[:filters] || {}
    @per_page = options[:per_page] || 10
    @start = options[:start] || 0
    @page = options[:page] || 1
    @sort = options[:sort] || []
  end

  class Error < RuntimeError; end
  class NotYetExecuted < RuntimeError; end

  def sort_params
    @sort.each_with_object({}) do |(param, direction), collection|
      if param == 'title'
        collection[:"title.exact"] = direction.to_sym
      else
        collection[param.to_sym] = direction.to_sym
      end
    end
  end

  def execute
    search = Tire.search(self.class.index.name) do |search|
      search.query  { |query| query.string @query }

      search.size   @per_page
      search.from   (@page - 1) * @per_page

      search.sort do |sort|
        sort.by sort_params
      end

      @filters.each do |field, values|
        search.filter :terms, {field.to_sym => values, :execution => 'and'}
      end

      # In order to have the facet counts reduced by our filters
      # we need to define the filters for each facet as well as
      # for the query as a whole
      @facet_by.each do |facet_option|
        search.facet facet_option do |facet|
          facet.terms facet_option.to_sym
          @filters.each do |field, values|
            facet.facet_filter :terms, {field.to_sym => values, :execution => 'and'}
          end
        end
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

  class <<self
    def index
      @index ||= Tire::Index.new(Need.tire.index.name)
    end

    def refresh_search_index
      index.refresh
    end

    def create_search_index
      if index.create(mappings: Need.tire.mapping_to_hash, settings: Need.tire.settings)
        true
      else
        Rails.logger.info "[ERROR] There has been an error when creating the index -- elasticsearch returned:",
          index.response
        false
      end
    end

    def delete_search_index
      index.delete
    end
  end
end