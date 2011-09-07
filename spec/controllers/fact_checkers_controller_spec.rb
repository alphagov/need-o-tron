require 'spec_helper'

describe FactCheckersController do
  describe "POST :create" do
    before(:each) do
      @need = Need.create
      controller.stubs(:authenticate_user!).returns(true)
      controller.stubs(:user_signed_in?).returns(false)
    end

    describe "with an existing Contact" do
      before(:each) do
        @contact = Contact.create(email: "matt@alphagov.co.uk")
      end

      it "creates the FactChecker correctly" do
        post :create, need_id: @need.id, fact_checker: {contact: {id: 1}}

        @need.fact_checkers.count.should == 1
        @need.fact_checkers.first.contact.should == @contact
      end

      it "creates the FactChecker correctly even though only the Contact's email was given" do
        post :create, need_id: @need.id, fact_checker: {contact: {email: "matt@alphagov.co.uk"}}

        @need.fact_checkers.count.should == 1
        @need.fact_checkers.first.contact.should == @contact
      end
    end

    describe "with a new Contact" do
      it "creates the Contact and FactChecker correctly" do
        post :create, need_id: @need.id, fact_checker: {contact: {email: "matt@alphagov.co.uk"}}

        @need.fact_checkers.count.should == 1
        @need.fact_checkers.first.contact.email.should == 'matt@alphagov.co.uk'
      end
    end
  end
end
