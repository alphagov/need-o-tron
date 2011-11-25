# This configuration is suitable for development, it should be managed by puppet
# in production.
# TODO: Check if this is thread/forked process safe under passenger. Possible risk
# that client connections get copied when passenger forks a process but the mutexes
# protecting those connections do not.
require 'active_record_ext'

if Rails.env.test?                                                     
  NeedStateListener.client = Marples::NullTransport.instance 
  ActiveRecord::Base.marples_transport = Marples::NullTransport.instance
else
  stomp_url = "failover://(stomp://support.cluster:61613,stomp://support.cluster:61613)"
  NeedStateListener.logger = Rails.logger

  if defined?(PhusionPassenger)
    PhusionPassenger.on_event(:starting_worker_process) do |forked|
      if forked
        NeedStateListener.client = Stomp::Client.new stomp_url    
        ActiveRecord::Base.marples_transport = Stomp::Client.new stomp_url
      end
    end
  else
    NeedStateListener.client = Stomp::Client.new stomp_url
    ActiveRecord::Base.marples_transport = Stomp::Client.new stomp_url
  end
end
