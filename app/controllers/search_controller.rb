class SearchController < ApplicationController
  before_filter :validate_filters
  before_filter :set_default_sort

  def index
    @current_page = (params[:page] || 1).to_i
    @facets = %w{priority writing_dept status kind tag}
    @search = NeedSearch.new(
      params[:query],
      facet_by: @facets,
      filters: @filters,
      per_page: per_page,
      page: @current_page,
      sort: sort_params
    )
    @search.execute
  rescue NeedSearch::Error => e
    flash.now[:error] = e.message
  end

  def per_page
    per_page = (params[:per_page] || 50).to_i
    [1, per_page].max
  end

  private
    def validate_filters
      filters = (params[:filters] || '').split('/').map{|item| NeedsHelper::deparameterize_filter(item) }
      if (filters.size % 2) != 0
        raise ActionController::RoutingError.new('Not Found')
      end
      @filters = {}
      filters.each_slice(2) do |field, value|
        @filters[field] = [] unless @filters.has_key?(field)
        @filters[field] << value
      end
    end

    def set_default_sort
      if ! (params[:sort_by] && params[:sort_dir])
        params[:sort_by] = 'title'
        params[:sort_dir] = 'asc'
      end
    end

    def sort_params
      sort = []
      sort << [params[:sort_by], params[:sort_dir]]
      if params[:sort_by] == 'title'
        sort << ["id", "asc"]
      else
        sort << ["title", "asc"]
      end
      sort
    end
end
