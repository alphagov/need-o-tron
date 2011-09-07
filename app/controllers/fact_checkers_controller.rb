class FactCheckersController < InheritedResources::Base
  belongs_to :need

  def search
    render :json => Contact.where('email LIKE ?', "%#{params[:term]}%").collect { |c| {value: c.email} }
  end

 def build_fact_checker
    raise unless params[:fact_checker] && params[:fact_checker][:contact]
    contact_params = params[:fact_checker][:contact]
    if contact_params[:id]
      end_of_association_chain.build(contact: Contact.find(contact_params[:id]))
    elsif contact_params[:email]
      contact = Contact.find_or_create_by_email(contact_params[:email].strip)
      end_of_association_chain.build(contact: contact)
    end
  end

  def build_resource
    get_resource_ivar || set_resource_ivar(build_fact_checker)
  end

  def create
    create! do |success, failure|
      success.json { render :json => resource.to_json(:include => :contact), :status => 201 }
    end
  end

  def destroy
    destroy! do |success, failure|
      success.json do
        render :text => "bye bye"
      end
    end
  end
end
