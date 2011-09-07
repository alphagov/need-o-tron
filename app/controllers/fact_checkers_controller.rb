class FactCheckersController < InheritedResources::Base
  belongs_to :need

  def search
    render :json => Contact.where("email LIKE %?%", params[:term]).collect { |c| {label: c.email, value: c.id} }
  end

  def destroy
    destroy! do |success, failure|
      success.json do
        render :text => "bye bye"
      end
    end
  end
end
