class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :unless => :auth_start_controller?
  before_filter :set_current_user_in_thread, :if => :user_signed_in?

  protected
    def authenticate_user!
      request.env['warden'].authenticate!(:signonotron)
    end

    def user_signed_in?
      request.env['warden'].authenticated?
    end
    helper_method :user_signed_in?

    def current_user
      request.env['warden'].authenticated? ? request.env['warden'].user : nil
    end

    def set_current_user_in_thread
      Thread.current[:current_user] = current_user
    end

    def authenticate_inviter!
      authenticate_user! and current_user.role == 'superuser'
    end

    def auth_start_controller?
      params[:controller] == 'auth_start'
    end
end
