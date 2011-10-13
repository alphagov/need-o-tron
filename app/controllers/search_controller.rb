class SearchController < ApplicationController
  before_filter :validate_filters
  
  def index
    @facets = %w{tag writing_dept kind status priority}
    @search = NeedSearch.new(params[:query], facet_by: @facets, filters: @filters)
    @search.execute
  rescue NeedSearch::Error => e
    flash.now[:error] = e.message
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