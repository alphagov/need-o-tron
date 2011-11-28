namespace :sync do
  desc "Sync need data to other apps"
  task :data => :environment do                      
    count = 0
    Need.all.each do |need|     
      if need.being_worked_on?
        Messenger.instance.send 'updated', need 
        count += 1
        puts "[#{count}] [#{need.status}] #{need.title} pushed to queue"
      else
        puts "-- #{need.title} skipped [#{need.status}]"
      end
    end         
    puts "Total records pushed to queue: #{count}"
  end                                                                      
  
end
