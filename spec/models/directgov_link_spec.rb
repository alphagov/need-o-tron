require 'spec_helper'

describe DirectgovLink do
  it "should provide access to the link on Directgov" do
    link = DirectgovLink.create(:directgov_id => "bob").should be_true
    link.url.should == DirectgovLink::DIRECTGOV_DOMAIN + link.directgov_id
  end

  it "should require a directgov_id" do
    expect { DirectgovLink.create }.should raise_error
  end
end
