class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :unless => :devise_controller?
  before_filter :set_current_user_in_thread, :if => :user_signed_in?
  
  protected
    def set_current_user_in_thread
      Thread.current[:current_user] = current_user
    end
  
    def authenticate_inviter!
      authenticate_user! and current_user.role == 'superuser'
    end
end
