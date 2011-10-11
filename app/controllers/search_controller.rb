require 'needs_csv'
require 'csv'
require 'ostruct'

class SearchController < ApplicationController

  def index
    @needs = NeedSearch.new(params[:query]).execute.map do |need|
      OpenStruct.new(need)
    end
  rescue NeedSearch::Error => e
    flash.now[:error] = e.message
    @needs = []
  end
end