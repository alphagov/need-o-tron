require 'spec_helper'

describe NeedsController do
  describe "when signed in" do
    before(:each) do
      @need_user = User.create!(:name => "Test User", :email => "rod@example.com", :uid => "rod", :version => 1)
      @need_user.should be_valid

      controller.stubs(:current_user).returns(@need_user)
      controller.stubs(:authenticate_user!).returns(true)
      controller.stubs(:user_signed_in?).returns(false)
    end

    describe "GET show.json" do

      describe "when loading show json" do

        before(:each) do
          @json_need = Need.new :title => 'Test', :url => 'http://test.alphagov.co.uk/', :description => "Test", :notes => "Testing"
          @json_need.save
          @json_need.creator = @need_user

          @json_need.fact_checkers.create :email => 'bob@alphagov.co.uk'
          @json_need.update_attribute(:writing_department, WritingDepartment.create(:name => 'GDS'))
          @json_need.policy_departments.create :name => 'GDS'
        end

        it "should show each need in JSON" do
          get :show, format: 'json', id: @json_need.id

          response.body.should == { need: { title: "Test", status: "new", url: 'http://test.alphagov.co.uk/', description: "Test", notes: "Testing", tag_list: nil, kind: 'none', writing_team: { id: WritingDepartment.first.id, name: 'GDS' }, fact_checkers: [ { fact_checker: { email: "bob@alphagov.co.uk" } } ], policy_owners: [ { policy_owner: { id: 1, name: "GDS" } } ] }}.to_json
        end

      end
    end

    describe "deleting a need" do

      describe "as an admin" do
        before(:each) do
          controller.stubs(:ensure_user_is_admin!).returns(true)
        end

        it "should delete a new need" do
          @need = Need.create!(:status => Need::NEW)
          delete :destroy, id: @need.id

          flash[:notice].should =~ /successfully destroyed/
        end

        it "should return an error for an in progress need" do
          @need = Need.create!(:status => Need::IN_PROGRESS)
          delete :destroy, id: @need.id

          flash[:alert].should =~ /can't be destroyed/
        end
      end

      describe "as a regular user" do
        it "should not delete anything" do
          @need = Need.create!(:status => Need::NEW)
          delete :destroy, id: @need.id

          response.status.should == 403
        end
      end
    end
  end
end
