class ApplicationController < ActionController::Base
  include GDS::SSO::ControllerMethods
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :require_signin_permission!
  before_filter :set_current_user_in_thread
  # the user_signed_in? if here is needed becaue otherwise we require an admin user
  # on the OmniAuth callback controller action, which is exceeding lethal
  before_filter :ensure_user_is_admin!, :except => [:show, :create, :index, :new], :if => :user_signed_in?
  skip_before_filter :ensure_user_is_admin!, :if => lambda { |c|
    c.controller_name == "authentications"
  }

  include NestedFormHelper

  def ensure_user_is_admin!
    unless current_user.is_admin?
      render :text => "You must be a need-o-tron admin to use this application", :status => :forbidden
      return false
    end
  end

  protected
    def set_current_user_in_thread
      if user_signed_in?
        Thread.current[:current_user] = current_user
        params[:_signed_in_user] = current_user.name
      end
    end
end
