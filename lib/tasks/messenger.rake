namespace :messenger do
  desc "Listen for need_satisified messages so that the need status can be updated"
  task :listen => :environment do
    Daemonette.run("needotron_satisfied_need_listener") do
      Rake::Task["environment"].invoke
      SatisfiedNeedListener.new.listen
    end
  end
end
