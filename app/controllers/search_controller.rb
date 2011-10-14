class SearchController < ApplicationController
  before_filter :validate_filters
  
  def index
    @current_page = (params[:page] || 1).to_i
    @facets = %w{tag writing_dept kind status priority}
    @search = NeedSearch.new(
      params[:query], 
      facet_by: @facets, 
      filters: @filters,
      per_page: per_page,
      start: (@current_page - 1) * per_page
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
      filters = (params[:filters] || '').split('/')
      if (filters.size % 2) != 0
        raise ActionController::RoutingError.new('Not Found')
      end
      @filters = {}
      filters.each_slice(2) do |field, value|
        @filters[field] = [] unless @filters.has_key?(field)
        @filters[field] << value
      end
    end
end