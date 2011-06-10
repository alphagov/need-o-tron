class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :unless => :devise_controller?
  
  protected
    def authenticate_inviter!
      authenticate_user! and current_user.role == 'superuser'
    end
end
