require 'marples/model_action_broadcast'
ActiveRecord::Base.class_eval do
  include Marples::ModelActionBroadcast
  
end