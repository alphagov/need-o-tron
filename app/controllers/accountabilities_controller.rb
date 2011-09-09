class AccountabilitiesController < InheritedResources::Base
  belongs_to :need

  def search
    render :json => Department.where('name LIKE ?', "%#{params[:term]}%").collect { |c| {value: c.name} }
  end

 def build_accountability
    raise unless params[:accountability] && params[:accountability][:department]
    department_params = params[:accountability][:department]
    if department_params[:id]
      end_of_association_chain.build(department: Department.find(department_params[:id]))
    elsif department_params[:name]
      department = Department.find_or_create_by_name(department_params[:name].strip)
      end_of_association_chain.build(department: department)
    end
  end

  def build_resource
    get_resource_ivar || set_resource_ivar(build_accountability)
  end

  def create
    create! do |success, failure|
      success.json { render :json => resource.to_json(:include => :department), :status => 201 }
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
