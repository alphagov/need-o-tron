require 'spec_helper'

describe NeedsController do
  describe "GET show.json" do
    before(:each) do
      @need_user = User.create!(:name => "Test User", :email => "rod@example.com", :uid => "rod", :version => 1)
      @need_user.should be_valid

      controller.stubs(:authenticate_user!).returns(true)
      controller.stubs(:user_signed_in?).returns(false)
    end

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
end
