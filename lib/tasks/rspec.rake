if Rails.env.development?
  namespace :spec do
    RSpec::Core::RakeTask.new(:acceptance) do |task|
      task.pattern = 'spec/acceptance/*_spec.rb'
    end
  end
end
