require 'needs_csv'
require 'csv'

class NeedsController < InheritedResources::Base
  has_scope :in_state
  skip_before_filter :authenticate_user!, :if => lambda { |c|
    c.action_name == 'show' && c.request.format.json?
  }

  def index
    index! do |format|
      format.csv { render :csv => NeedsCsv.new(collection, Time.zone.now) }
    end
  end        

  def edit
    edit! do |format|
      format.html {
        @need.fact_checkers.build while @need.fact_checkers.size < 5
      }
    end
  end

  def show
    show! do |format|
      format.json { # show.json.rabl
      }
    end
  end

  def print
    @need = Need.find params[:id]
    render :layout => false
  end

  def update
    update! do |success, failure|
      failure.html {
        if request.referer.match(/needs\/\d+/)
          @need.reload
          flash.now[:alert] = "We weren't able to save your changes. Please review the form below and try again"
          render :action => 'show'
        else
          render :action => 'edit'
        end
      }
    end
  end

end
