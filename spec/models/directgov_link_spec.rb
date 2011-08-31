require 'spec_helper'

describe DirectgovLink do
  it "should provide access to the link on Directgov" do
    stub_request(:any, /.*syndication.innovate.direct.gov.uk.*/).to_return(:status => [404, "Not Found"])
    link = DirectgovLink.create(:directgov_id => "bob").should be_true
    link.url.should == DirectgovLink::DIRECTGOV_DOMAIN + link.directgov_id
  end

  it "should require a directgov_id" do
    link = DirectgovLink.create
    link.should have(1).error_on(:directgov_id)
  end

  describe "Verifying DG links" do
    it "can retrieve JSON from the DG API" do
      stub_request(:get, /.*syndication.innovate.direct.gov.uk\/doc\/article\/DG_10012514.json*/).
        to_return(lambda { |request| File.open(File.expand_path('../../fixtures/dg_api.curl', __FILE__)) })

      dg = DirectgovLink.new(directgov_id: "DG_10012514")
      dg.verify_dg!.should be_true
      dg.title.should == "Applying for a provisional driving licence : Directgov - Motoring"
    end
  end
end
