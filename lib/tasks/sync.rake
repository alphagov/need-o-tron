namespace :sync do
  desc "Sync need data to other apps"
  task :data => :environment do                      
    count = 0
    Need.all.each do |need|                    
      Messenger.instance.send 'updated', need 
      count += 1
      puts "[#{count}] #{need.title} pushed to queue"
    end         
    puts "Total records pushed to queue: #{count}"
  end                                                                      
  
end
