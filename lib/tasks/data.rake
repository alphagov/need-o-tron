task :move_from_ready_for_carding => :environment do
  Need.where(:status => "ready-for-carding").each { |n| n.status =
"format-assigned"; n.save! }
end
