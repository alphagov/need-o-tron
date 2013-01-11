source 'http://rubygems.org'
source 'https://gems.gemfury.com/vo6ZrmjBQu5szyywDszE/'

gem 'rails', '3.1.10'

gem 'gds-warmup-controller'

gem 'sqlite3'

gem 'mysql2', '0.3.10'
gem 'rdiscount'

gem 'aws-ses', :require => 'aws/ses'
gem 'gds-api-adapters', '4.1.3'

if ENV['BUNDLE_ENV'] == 'DEV'
  gem "gds-sso", :path => '../gds-sso'
else
  gem "gds-sso", '~> 1.2.0'
end

gem 'carrierwave'
gem 'delsolr', :git => 'https://github.com/alphagov/delsolr.git',
  :ref => '0e78228be3091bc2240aa0ba0b5c60791cad07c9'

gem 'rabl'
gem 'formtastic'
gem 'inherited_resources'
gem 'has_scope'

gem 'plek', '0.1.22'

gem 'exception_notification'
gem 'lograge'
gem 'unicorn', '4.3.1'

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
  gem 'shoulda', '3.0.1'
  gem 'mocha'
  gem 'webmock', require: false
  gem 'capybara', '~> 1.1.1'
  gem "capybara-webkit", require: false
end
