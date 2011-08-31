require 'spec_helper'

describe Need do
  before(:each) do
    @user = User.create(:name => "rod", :email => "rod@example.com", :uid => "rod", :version => 1)
    @user.should be_valid
    Thread.current[:current_user] = @user
    @need = Need.create
  end

  it "set creator when saved" do
    @need.creator.should == @user
  end

  it "should tell us if the format has been assigned" do
    @need.format_assigned?.should == false
    @need.status = Need::FORMAT_ASSIGNED
    @need.format_assigned?.should == true
  end

  it "should tell us when a decision is made" do
    @need.decision_made?.should be_false
    @need.reason_for_decision = "fake reason"
    @need.record_decision_info
    @need.decision_made?.should be_true
  end

  it "should tell us when a formatting decision is made" do
    @need.formatting_decision_made?.should be_false
    @need.reason_for_formatting_decision = "fake reason"
    @need.record_formatting_decision_info
    @need.formatting_decision_made?.should be_true
  end
end
