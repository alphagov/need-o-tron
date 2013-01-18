RSpec.configure do |config|
  config.before :each do
    NeedSearch.delete_search_index
    NeedSearch.create_search_index
  end

  config.after :all do
    NeedSearch.delete_search_index
  end
end