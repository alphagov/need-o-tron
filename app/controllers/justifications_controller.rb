class JustificationsController < InheritedResources::Base
  belongs_to :need
  actions :all, :except => [:show, :index]
end
