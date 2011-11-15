namespace :messenger do
  desc "Listen for publication state change messages so that the related need status can be updated"
  task :listen do
    Daemonette.run("needotron_need_state_listener") do
      Rake::Task["environment"].invoke
      NeedStateListener.new.listen
    end
  end
end
