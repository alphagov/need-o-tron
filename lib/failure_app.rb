require "action_controller/metal"

# Failure application that will be called every time :warden is thrown from
# any strategy or hook. 
class FailureApp < ActionController::Metal
  include ActionController::RackDelegation
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers

  def self.call(env)
    puts "OMGFAILLOL"
    action(:respond).call(env)
  end
  
  def respond
    puts "OMGFAILLOL MORE"
    redirect
  end
  
  def redirect
    store_location!
    redirect_to auth_start_path
  end

  # Stores requested uri to redirect the user after signing in. We cannot use
  # scoped session provided by warden here, since the user is not authenticated
  # yet, but we still need to store the uri based on scope, so different scopes
  # would never use the same uri to redirect.
  def store_location!
    session["return_to"] = env['warden.options'][:attempted_path] if request.get?
  end
end
