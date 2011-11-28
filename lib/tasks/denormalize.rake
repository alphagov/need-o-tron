namespace :denormalize do
   
  task :fact_checkers => :environment do
    Need.find_each do |need|
      need.fact_checkers.find_each do |fact_checker|
        fact_checker.email = fact_checker.contact.email.strip
        if fact_checker.save
          puts "Updated #{need.title} with #{fact_checker.email}"
        end
      end
    end
  end

end