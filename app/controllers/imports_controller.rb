class ImportsController < InheritedResources::Base
  before_filter :ensure_user_is_admin!, :if => :user_signed_in?
  actions :new, :create

  def create
    create! do |success, failure|
      success.html { redirect_to needs_url }
      failure.html { redirect_to needs_url }
    end
  end
end
