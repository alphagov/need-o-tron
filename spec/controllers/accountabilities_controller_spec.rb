require 'spec_helper'

describe AccountabilitiesController do
  describe "POST :create" do
    before(:each) do
      @need = Need.create
      controller.stubs(:authenticate_user!).returns(true)
      controller.stubs(:user_signed_in?).returns(false)
    end

    describe "with an existing Contact" do
      before(:each) do
        @department = Department.create(name: "HM Treasury")
      end

      it "creates the Accountability correctly" do
        post :create, need_id: @need.id, accountability: {department: {id: 1}}

        @need.accountabilities.count.should == 1
        @need.accountabilities.first.department.should == @department
      end

      it "creates the Department correctly even though only the Department's name was given" do
        post :create, need_id: @need.id, accountability: {department: {name: "HM Treasury"}}

        @need.accountabilities.count.should == 1
        @need.accountabilities.first.department.should == @department
      end
    end

    describe "with a new Department" do
      it "creates the Department and Accountability correctly" do
        post :create, need_id: @need.id, accountability: {department: {name: "HM Treasury"}}

        @need.accountabilities.count.should == 1
        @need.accountabilities.first.department.name.should == "HM Treasury"
      end
    end
  end
end
