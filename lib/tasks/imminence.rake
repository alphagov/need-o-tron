namespace :imminence do             
  desc "Loads all imminence data into the local database cache"
  task :sync => [:environment, :policy_owners, :writing_teams] do
  end
  
  desc "Loads policy departments from imminence into the `departments` table"
  task :policy_owners => :environment do
    uri = Plek.current.find("imminence") + '/data_sets/public_bodies.json'
    puts "Loading #{uri}..."
    public_bodies = JSON.parse open( uri ).read
    puts "Found #{public_bodies.size} policy owners."                
    public_bodies.each_with_index do |department, i|      
      d = Department.find_or_initialize_by_id(department['id'])
      d.name = department['name']                         
      if d.save
        puts "[#{i+1}/#{public_bodies.size}] "+ ( (d.new_record?) ? "Added" : "Updated" ) + " `#{department['name']}` (##{department['id']})"
      else
        puts "[#{i+1}/#{public_bodies.size}] Could not add `#{department['name']} (##{department['id']})`"
      end
    end                                                              
    puts "Import complete. There are now #{Department.count} policy owners in Need-O-Tron."
  end
  
  desc "Loads writing teams from imminence into the `writing_teams` table"
  task :writing_teams => :environment do
    uri = Plek.current.find("imminence") + '/data_sets/writing_teams.json'
    puts "Loading #{uri}..."
    data = JSON.parse open( uri ).read
    puts "Found #{data.size} writing teams."                
    data.each_with_index do |department, i|      
      d = WritingDepartment.find_or_initialize_by_id(department['id'])
      d.name = department['name']                         
      print "[#{i+1}/#{data.size}] "
      if d.save
        puts ( (d.new_record?) ? "Added" : "Updated" ) + " `#{department['name']}` (##{department['id']})"
      else
        puts "Could not add `#{department['name']} (##{department['id']})`"
      end
    end                                                              
    puts "Import complete. There are now #{WritingDepartment.count} writing teams in Need-O-Tron."
  end
end