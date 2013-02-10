RSpec.configure do |config|
  config.before :each do
    NeedSearch.delete_search_index
    unless NeedSearch.create_search_index
      exit(1)
    end
  end

  config.after :all do
    NeedSearch.delete_search_index
  end
end