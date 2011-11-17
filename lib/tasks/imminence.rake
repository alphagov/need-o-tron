namespace :imminence do
  desc "Loads all the policy departments from imminence into the `departments` table"
  task :policy_departments => :environment do
    uri = Plek.current.find("imminence") + '/data_sets/public_bodies.json'
    puts "Loading #{uri}..."
    public_bodies = JSON.parse open( uri ).read
    puts "Found #{public_bodies.size} policy departments."                
    public_bodies.each_with_index do |department, i|
      Department.create(:name => department['id'])
      puts "[#{i+1}/#{public_bodies.size}] Added `#{department['id']}`"
    end                                                              
    puts "Import complete. There are now #{Department.count} policy departments in Need-O-Tron."
  end
end