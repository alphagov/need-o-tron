ENV["RAILS_ENV"] ||= 'test'
require_relative "../../config/environment"
require 'rspec/rails'
require 'capybara/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.mock_with :mocha
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.include(SetMatchers)
  config.include(Capybara::DSL)

  config.before :each do
    Machinist.reset_before_test
    DatabaseCleaner.clean
    $solr.delete_by_query("rails_env:#{Rails.env}")
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium
Capybara.app = Rack::Builder.new do
  map "/" do
    run Capybara.app
  end
end