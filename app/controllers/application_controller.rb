class ApplicationController < ActionController::Base
  include GDS::SSO::ControllerMethods
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_current_user_in_thread, :if => :user_signed_in?

  protected
    def set_current_user_in_thread
      Thread.current[:current_user] = current_user
    end
end
