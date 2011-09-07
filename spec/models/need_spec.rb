require 'spec_helper'

describe Need do
  before(:each) do
    @user = User.create(:name => "rod", :email => "rod@example.com", :uid => "rod", :version => 1)
    @user.should be_valid
    Thread.current[:current_user] = @user
    @need = Need.create
  end

  describe "associations" do
    it { should have_many :fact_checkers }
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

  describe "priority" do
    describe "displaying" do
      it "renders 1 as 'low'" do
        @need.priority = 1
        @need.named_priority.should == 'low'
      end

      it "renders 2 as 'medium'" do
        @need.priority = 2
        @need.named_priority.should == 'medium'
      end

      it "renders 3 as 'high'" do
        @need.priority = 3
        @need.named_priority.should == 'high'
      end
    end

    describe "setting" do
      [[['l', 'low'], 1], [['m', 'medium'], 2], [['h', 'high'], 3]].each do |inputs, expected|
        inputs.each do |input|
          it "accepts '#{input}' for #{expected}" do
            @need.priority = input
            @need.priority.should == expected
          end
        end
      end
    end
  end
end
