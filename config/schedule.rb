set :output, {:error => 'log/cron.error.log', :standard => 'log/cron.log'}

every :day, :at => '8am' do
  rake "reports:analytics"
end
