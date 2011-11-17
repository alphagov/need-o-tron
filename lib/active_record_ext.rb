require 'marples/model_action_broadcast'

ActiveRecord::Base.class_eval do
  include Marples::ModelActionBroadcast
end

ActiveRecord::Base.marples_client_name = 'need-o-tron'
ActiveRecord::Base.marples_logger = Rails.logger
