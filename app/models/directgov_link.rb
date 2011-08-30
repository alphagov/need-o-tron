require 'net/http'

class DirectgovLink < ActiveRecord::Base
  validates :directgov_id, :presence => true
  before_create :verify_dg!

  belongs_to :need

  DIRECTGOV_DOMAIN = "http://www.direct.gov.uk/en/"

  def url
    DIRECTGOV_DOMAIN + directgov_id
  end

  def self.fetch_article(directgov_id)
    Net::HTTP.start('syndication.innovate.direct.gov.uk') {|http|
      req = Net::HTTP::Get.new("/doc/article/#{directgov_id}.json")
      req.basic_auth NeedOTron::Application.config.dg_api.user, NeedOTron::Application.config.dg_api.password
      http.request(req)
    }
  end

  def verify_dg!
    response = self.class.fetch_article(directgov_id)
    if response.code == "200"
      self.found = true
      if response.content_type == 'application/json'
        body = JSON.parse(response.body)
        self.title = body['article']['full_title'] if body.has_key?('article')
      end
    end
    self.found
  end
end
