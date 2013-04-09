class Source < ActiveRecord::Base
  belongs_to :need

  KINDS = [
    'legacy_service',
    'existing_service',
    'government_campaign',
    'government_obligation',
    'legal_framework',
    'official_channel',
    'search_behaviour',
    'user_request'
  ]

  validates :kind, :presence => true, :inclusion => { :in => KINDS }
end
