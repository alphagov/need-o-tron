namespace :migrate do

  task :rename_bin_to_icebox => :environment do
    Need.where(status: 'bin').find_each do |need|
      need.update_attribute(:status, Need::ICEBOX)
    end
  end

end