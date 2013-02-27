namespace :data do
  desc "Use tire to populate the elasticsearch index"
  task :populate_search_index => :environment do
    Need.find_each { |n| n.tire.update_index }
  end
end