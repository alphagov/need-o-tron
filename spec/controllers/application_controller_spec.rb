require 'spec_helper'

describe ApplicationController do
  describe "Guard filters" do
    describe "ensure_user_is_admin!" do
      controller do
        skip_before_filter :authenticate_user!
        skip_before_filter :require_signin_permission!

        def show
          render :text => "woo", :status => 200
        end

        def edit
          render :text => "woo", :status => 200
        end

        def create
          redirect_to('/other_path')
        end

        def update
          render :text => "woo", :status => 200
        end

        def new
          render :text => "woo", :status => 200
        end
      end

      before(:each) do
        @user = User.new
        controller.stubs(:user_signed_in?).returns(true)
        controller.stubs(:current_user).returns(@user)
      end

      describe "Non-admin users" do
        it "can access :show" do
          get :show, :id => 1
          response.code.should == "200"
        end

        it "can access :new" do
          get :new
          response.code.should == "200"
        end

        it "can access :create" do
          post :create
          response.should redirect_to('/other_path')
        end

        it "cannot access :update" do
          put :update, :id => 1
          response.code.should == "403"
        end

        it "cannot access :edit" do
          get :edit, :id => 1
          response.code.should == "403"
        end
      end


      describe "Admin users" do
        before(:each) do
          @user.is_admin = true
        end

        it "can access :show" do
          get :show, :id => 1
          response.code.should == "200"
        end

        it "can access :new" do
          get :new
          response.code.should == "200"
        end

        it "can access :create" do
          post :create
          response.should redirect_to('/other_path')
        end

        it "can access :update" do
          put :update, :id => 1
          response.code.should == "200"
        end

        it "cannot access :edit" do
          get :edit, :id => 1
          response.code.should == "200"
        end
      end
    end
  end
end
