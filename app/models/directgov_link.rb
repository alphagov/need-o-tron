class DirectgovLink < ActiveRecord::Base
  validate :directgov_id, :presence => true

  belongs_to :need

  DIRECTGOV_DOMAIN = "http://www.direct.gov.uk/en/"

  def url
    DIRECTGOV_DOMAIN + directgov_id
  end

end
