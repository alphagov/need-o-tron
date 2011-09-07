class ImportsController < InheritedResources::Base
  actions :new, :create

  def create
    create! do |success, failure|
      success.html { redirect_to needs_url }
      failure.html { redirect_to needs_url }
    end
  end
end
