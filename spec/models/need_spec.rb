require 'spec_helper'

describe Need do
  describe "with the action being tested getting executed in the setup block" do
    before(:each) do
      @user = User.create(:name => "rod", :email => "rod@example.com", :uid => "rod", :version => 1)
      @user.should be_valid
      Thread.current[:current_user] = @user
      @need = Need.create!
    end

    describe "associations" do
      it { should have_many :fact_checkers }
      it { should have_many :accountabilities }
      it { should belong_to :writing_department }
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

    describe "deleting a need" do
      it "can delete a need which has not been started" do
        @need = Need.create :status => Need::NEW
        @need.reload

        @need.destroy.should be_true
      end

      it "cannot delete a need which is in progress or done" do
        @in_progress_need = Need.create! :status => Need::IN_PROGRESS
        @in_progress_need.reload

        expect{@in_progress_need.destroy}.to raise_error(Need::CannotDeleteStartedNeed)
      end

      it "cannot delete a need which is done" do
        @done_need = Need.create! :status => Need::DONE, :url => "http://example.com/"
        @done_need.reload

        expect{@done_need.destroy}.to raise_error(Need::CannotDeleteStartedNeed)
      end
    end

    describe "handling fact checker updates" do
      it "can return all current Fact Checker's Contact emails" do
        @need.fact_checkers.create(email: 'matt@alphagov.co.uk')
        @need.fact_checkers.create(email: 'ben@alphagov.co.uk')

        @need.current_fact_checker_emails.should == ['matt@alphagov.co.uk', 'ben@alphagov.co.uk']
      end

      it "can create a fact checker and contact from its email" do
        @need.fact_checkers.build(email: 'matt@alphagov.co.uk')
        @need.fact_checkers.first.email.should == 'matt@alphagov.co.uk'
      end

      it "can remove a fact checker from its contact's email" do
        fc_to_be_removed = @need.fact_checkers.create(email: 'matt@alphagov.co.uk')
        fc_to_remain = @need.fact_checkers.create(email: 'ben@alphagov.co.uk')

        @need.fact_checkers.length.should == 2

        factchecker = @need.fact_checkers.find_by_email(fc_to_be_removed.email)
        factchecker.destroy

        FactChecker.where(:need_id => @need.id).count.should == 1
        FactChecker.where(:need_id => @need.id).first.should == fc_to_remain
      end
    end

    describe "handling accountability updates" do
      it "can return all current Accountabilities' Department names" do
        @need.accountabilities.build(department: Department.new(name: 'HM Treasury'))
        @need.accountabilities.build(department: Department.new(name: 'DoSAC'))

        @need.current_accountability_names.should == ['HM Treasury', 'DoSAC']
      end

      it "can create an accountability and department from its name" do
        @need.add_accountability_with_name('HM Treasury')
        @need.accountabilities.first.department.name.should == 'HM Treasury'
      end

      it "can remove a fact checker from its contact's email" do
        a_to_be_removed = @need.accountabilities.build(department: Department.new(name: 'HM Treasury'))
        a_to_remain = @need.accountabilities.build(department: Department.new(name: 'DoSAC'))

        @need.remove_accountability_with_name('HM Treasury')

        @need.accountabilities.length.should == 1
        @need.accountabilities.first.should == a_to_remain
      end
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
end
