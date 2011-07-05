require 'omniauth/oauth'
require 'multi_json'

# Authenticate to Bitly utilizing OAuth 2.0 and retrieve
# basic user information.
#
# @example Basic Usage
#     use GdsOauth, 'API Key', 'Secret Key'

class OmniAuth::Strategies::Gds < OmniAuth::Strategies::OAuth2
  # @param [Rack Application] app standard middleware application parameter
  # @param [String] api_key the application id as [provided by GDS]
  # @param [String] secret_key the application secret as [provided by Bitly]
  def initialize(app, api_key = nil, secret_key = nil, options = {}, &block)
    client_options = {
      :site => 'http://local.alphagov.co.uk:3001/',
      :authorize_url => 'http://local.alphagov.co.uk:3001/oauth/authorize',
      :access_token_url => 'http://local.alphagov.co.uk:3001/oauth/access_token'
    }

    super(app, :gds, api_key, secret_key, client_options, options, &block)
  end

  protected

  def user_hash
    @user_hash ||= MultiJson.decode(@access_token.get('/user.json'))['user']
  end

  def auth_hash
    OmniAuth::Utils.deep_merge(super, {'uid' => user_hash['uid'], 'name' => user_hash['name'], 'version' => user_hash['version'], 'email' => user_hash['email']})
  end
end