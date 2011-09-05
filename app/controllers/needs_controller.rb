require 'needs_csv'
require 'csv'

class NeedsController < InheritedResources::Base
  has_scope :in_state

  def index
    index! do |format|
      format.csv { render :csv => NeedsCsv.new(collection, Time.zone.now) }
    end
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

  def importer
    rows_changed = 0
    CSV.open(params[:csv], :headers => true) do |csv|
      csv.each do |row|
        if row['Id'] && row['Priority']
          need = Need.find_by_id(row['Id'])
          if need
            need.priority = row['Priority']
            need.save if need.changed?
          end
        end
      end
    end
    flash[:notice] = "#{rows_changed} needs updated"
    redirect_to(needs_path(:in_state => params[:in_state]))
  end
end
