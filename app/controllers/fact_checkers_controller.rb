class FactCheckersController < InheritedResources::Base
  belongs_to :need

  def search
    render :json => FactChecker.where('email LIKE ?', "%#{params[:term]}%").collect { |f| {value: f.email} }
  end
end
