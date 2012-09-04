require 'needs_csv'
require 'csv'

class NeedsController < InheritedResources::Base

  before_filter :ensure_user_is_admin!, :only => [:new, :edit, :create, :destroy]

  has_scope :in_state
  skip_before_filter [:authenticate_user!, :require_signin_permission!], :if => lambda { |c|
    c.action_name == 'show' && c.request.format.json?
  }

  rescue_from Need::CannotDeleteStartedNeed do
    flash[:alert] = "A need which has been started can't be destroyed"
    redirect_to @need
  end

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
        if request.referer.match(/needs\/\d+$/)
          @need.reload
          flash.now[:alert] = "We weren't able to save your changes. Please review the form below and try again"
          render :action => 'show'
        else
          render :action => 'edit'
        end
      }
    end
  end

  def collection
    @needs ||= Need.includes(:directgov_links, :fact_checkers, :existing_services, :justifications, :kind, :writing_department, {accountabilities: :department})
  end
end
