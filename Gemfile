source 'http://rubygems.org'

gem 'sprockets', :git => 'git://github.com/sstephenson/sprockets.git'

gem 'rails', '~> 3.1.0.rc4'

gem 'sqlite3'

gem 'mysql2'
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

# gem 'acts-as-taggable-on'

# Asset template engines
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

group :production do
  gem 'therubyracer'
end

group :development, :test do
  gem 'rspec-rails'
end

if ENV['RUBY_DEBUG']
  gem 'ruby-debug19'
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'mocha'
  gem 'cucumber-rails'
end
