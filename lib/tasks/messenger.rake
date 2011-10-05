namespace :messenger do
  desc "Listen for need_satisified messages so that the need status can be updated"
  task :listen => :environment do
    SatisfiedNeedListener.new.listen
  end
end
