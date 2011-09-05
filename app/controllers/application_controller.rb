class ApplicationController < ActionController::Base
  include GDS::SSO::ControllerMethods
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_current_user_in_thread, :if => :user_signed_in?
  # the user_signed_in? if here is needed becaue otherwise we require an admin user
  # on the OmniAuth callback controller action, which is exceeding lethal
  before_filter :ensure_user_is_admin!, :except => [:show, :create, :index, :new], :if => :user_signed_in?

  def ensure_user_is_admin!
    unless current_user.is_admin?
      render :text => "Unauthorised!", :status => :unauthorized
      return false
    end
  end

  protected
    def set_current_user_in_thread
      Thread.current[:current_user] = current_user
    end
end
