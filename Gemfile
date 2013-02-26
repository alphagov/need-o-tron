source 'http://rubygems.org'
source 'https://gems.gemfury.com/vo6ZrmjBQu5szyywDszE/'

gem 'rails', '3.1.10'

gem 'gds-warmup-controller'

gem 'sqlite3'

gem 'mysql2', '0.3.10'
gem 'rdiscount'

gem 'aws-ses', :require => 'aws/ses'
gem 'gds-api-adapters', '4.1.3'

if ENV['BUNDLE_ENV']
  gem "gds-sso", :path => '../gds-sso'
else
  gem "gds-sso", '3.0.0'
end

gem 'carrierwave'

gem 'tire'

gem 'rabl', '0.5.1'
gem 'formtastic'
gem 'inherited_resources'
gem 'has_scope'

gem 'plek', '0.1.22'

gem 'exception_notification'
gem 'lograge'
gem 'unicorn', '4.3.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'therubyracer', '~> 0.9.4'
end

group :reporting do
  gem 'garb', '~> 0.9.1'
  gem 'oauth'
  gem 'terminal-table'
  gem 'whenever', :require => false
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec-rails', '2.12.2'
end

group :test do
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
  gem "factory_girl_rails", "1.2.0"
  gem 'database_cleaner'
  gem 'shoulda', '3.0.1'
  gem 'mocha'
  gem 'webmock', require: false
  gem 'capybara', '~> 1.1.1'
end
