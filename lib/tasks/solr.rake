namespace :solr do
  desc "Index/re-index all needs"
  task :index_all => :environment do
    Need.index_all
  end
end
  