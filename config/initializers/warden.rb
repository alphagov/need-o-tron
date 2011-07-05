require 'warden'
require 'omniauth/oauth'
require 'failure_app'
require 'oa-oauth-gds'

Warden::Manager.serialize_into_session do |user|
  user.uid
end

Warden::Manager.serialize_from_session do |uid|
  User.find_by_uid(uid)
end

Warden::Strategies.add(:signonotron) do
  def valid?
    true
  end

  def authenticate!
    puts "REQUEST ENV OmniAuth: #{request.env['omniauth.auth'].inspect}"
    puts "request.env['omniauth.auth'].nil?: #{request.env['omniauth.auth'].nil?.inspect}"
    if request.env['omniauth.auth'].nil?
      fail!("No credentials, bub") 
    else
      user = prep_user(request.env['omniauth.auth'])
      success!(user)
    end
  end

  private

  def prep_user(auth_hash)
    puts auth_hash.inspect
    user = User.find_for_gds_oauth(auth_hash)
    fail!("Couldn't process credentials") unless user
    user
  end
end


NeedOTron::Application.config.middleware.use OmniAuth::Builder do
  provider :gds, 'abcdefgh12345678', 'secret'
end

NeedOTron::Application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :signonotron
  manager.failure_app = FailureApp
end
