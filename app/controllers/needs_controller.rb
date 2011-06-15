class NeedsController < InheritedResources::Base
  has_scope :in_state
end
