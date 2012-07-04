require 'spec_helper'

describe FactCheckersController do
  describe "GET :search" do
    before(:each) do
      @need = Need.create
      controller.stubs(:authenticate_user!).returns(true)
      controller.stubs(:require_signin_permission!).returns(true)
      controller.stubs(:user_signed_in?).returns(false)
    end

    describe "with an existing fact checker" do
      before(:each) do
        @contact = FactChecker.create(email: "matt@alphagov.co.uk")
      end

      it "searches the fact checkers correctly" do
        get :search, need_id: @need.id, term: 'matt'

        response.body.should == [:value => "matt@alphagov.co.uk"].to_json
      end

    end
  end
end
