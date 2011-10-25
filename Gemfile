source 'http://rubygems.org'

gem 'oauth2', '0.4.1'
gem 'oa-core', '0.2.6'
gem 'oa-oauth', '0.2.6'

gem 'rails', '~> 3.1.0'
gem 'rack', '1.3.5'
gem 'rake', '0.9.2'

gem 'sqlite3'
#gem 'activerecord-sqlite3-adapter'

gem 'mysql2'
#gem 'activerecord-mysql2-adapter'
gem 'rdiscount'

if ENV['BUNDLE_ENV'] == 'DEV'
  gem "gds-sso", :path => '../gds-sso'
else
  gem "gds-sso", :git => 'git@github.com:alphagov/gds-sso.git'
end

gem 'carrierwave'
gem 'delsolr', :git => 'https://github.com/alphagov/delsolr.git'

gem 'formtastic'
gem 'inherited_resources'
gem 'has_scope'

gem 'pethau'
gem 'plek', :git => 'git@github.com:alphagov/plek.git'
gem 'stomp', '1.1.9'

# gem 'acts-as-taggable-on'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
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
