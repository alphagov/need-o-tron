namespace :users do
  namespace :admin do
    def privileges(state)
      raise unless ENV['email']
      u = User.find_by_email!(ENV['email'])
      u.is_admin = state
      u.save!
    end

    desc "grant admin privileges to a user: rake users:admin:grant email='joe@bloggs.com'"
    task :grant => :environment do
      privileges(true)
    end

    desc "remove admin privileges from a user: rake users:admin:remove email='joe@bloggs.com'"
    task :remove => :environment do
      privileges(false)
    end
  end
end
