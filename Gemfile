source 'https://rubygems.org'
source 'https://BnrJb6FZyzspBboNJzYZ@gem.fury.io/govuk/'

gem 'rails', '3.2.13'

gem 'mysql2', '0.3.10'
gem 'rdiscount', '1.6.8'

gem 'aws-ses', '0.4.4', :require => 'aws/ses'
gem 'gds-api-adapters', '4.1.3'

if ENV['BUNDLE_ENV']
  gem "gds-sso", :path => '../gds-sso'
else
  gem "gds-sso", '3.0.2'
end

gem 'carrierwave', '0.5.8'

gem 'tire', '0.5.3'

gem 'rabl', '0.5.1'
gem 'formtastic', '2.2.1'
gem 'formtastic-bootstrap', '2.1.1'

gem 'inherited_resources', '1.3.1'
gem 'has_scope', '0.5.1'

gem 'plek', '1.3.1'

gem 'exception_notification', '3.0.0'
gem 'lograge', '0.1.2'
gem 'unicorn', '4.3.1'

gem 'omniauth-gds', :require => 'omniauth-gds'

gem 'jquery-rails', '2.2.1'
gem 'bootstrap-sass', '2.3.1.0'
gem 'nested_form', '0.3.2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.6'
  gem 'uglifier', '2.0.1'
  gem 'therubyracer', '0.11.4'
end

group :development, :test do
  gem 'rspec-rails', '2.13.0'
end

group :test do
  gem 'sqlite3', '1.3.7'
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
  gem "factory_girl_rails", "4.2.0"
  gem 'database_cleaner'
  gem 'shoulda', '3.0.1'
  gem 'mocha', '0.13.3', require: false
  gem 'webmock', require: false
  gem 'capybara', '~> 1.1.1'
end
