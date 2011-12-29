namespace :reports do
  desc "Send a daily analytics report"
  task :analytics => :environment do
    interface = AnalyticsInterface.new('UA-26179049-1')
    daily = interface.daily_stats
    weekly = interface.weekly_stats
    details = interface.main_visits_data
    ReportMailer.daily_analytics(daily, weekly, details).deliver
  end
end