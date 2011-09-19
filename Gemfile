source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

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

gem 'formtastic'
gem 'inherited_resources'
gem 'has_scope'

gem 'plek'

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
  gem 'rspec-rails'
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
end

if ENV['RUBY_DEBUG']
  gem 'ruby-debug19'
end

group :test do
  gem 'shoulda'
  gem 'mocha'
  gem 'cucumber-rails'
  gem 'webmock'
end
