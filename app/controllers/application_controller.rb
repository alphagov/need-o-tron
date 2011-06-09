class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :unless => :devise_controller?
end
