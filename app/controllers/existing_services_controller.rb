class ExistingServicesController < InheritedResources::Base
  belongs_to :need
  
  def index
    redirect_to @need
  end
  
  def create
    create! { @need }
  end
  
  def update
    update! { @need }
  end
  
  def destroy
    destroy! { @need }
  end
end
