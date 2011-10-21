if Rails.env.development?
  namespace :spec do
    RSpec::Core::RakeTask.new(:acceptance) do |task|
      task.pattern = 'acceptance/*_spec.rb'
    end
  end
end
