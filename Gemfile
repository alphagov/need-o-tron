source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'
gem 'rack', '1.3.5'
gem 'rake', '0.9.2'

gem 'gds-warmup-controller'

gem 'sqlite3'

gem 'gelf'
gem 'mysql2'
gem 'rdiscount'

gem 'aws-ses', :require => 'aws/ses'
gem 'gds-api-adapters', '~> 0.0.15'

if ENV['BUNDLE_ENV'] == 'DEV'
  gem "gds-sso", :path => '../gds-sso'
else
  gem "gds-sso", '0.7.0'
end

gem 'carrierwave'
gem 'delsolr', :git => 'https://github.com/alphagov/delsolr.git',
  :ref => '0e78228be3091bc2240aa0ba0b5c60791cad07c9'

gem 'rabl'
gem 'formtastic'
gem 'inherited_resources'
gem 'has_scope'

gem 'plek', '~> 0'
gem 'stomp', '1.1.9'
gem 'marples', '~> 1.0'
gem 'daemonette', :git => 'git://github.com/alphagov/daemonette.git'

gem 'exception_notification'

# gem 'acts-as-taggable-on'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :reporting do
  gem 'garb', '~> 0.9.1'
  gem 'oauth'
  gem 'terminal-table'
  gem 'whenever', :require => false
end

gem 'jquery-rails'

group :production do
  gem 'therubyracer'
end

group :development, :test do
  gem 'machinist', '~> 2.0.0.beta1'
  gem 'rspec'
  gem 'rspec-core', '2.6.4'
  gem 'rspec-rails'
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
  gem "factory_girl", "2.1.2"
  gem "factory_girl_rails", "1.2.0"
end

if ENV['RUBY_DEBUG']
  gem 'ruby-debug19'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'mocha'
  gem 'webmock', require: false
  gem 'capybara', '~> 1.1.1'
  gem "capybara-webkit", require: false
  gem 'webmock'
end
