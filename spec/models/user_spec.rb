require 'spec_helper'

describe User do
  it "is not marked as an admin by default" do
    User.new.is_admin?.should be_false
  end

  describe "dealing with the GDS OmniAuth provider" do
    before(:each) do
      @auth_hash = {
        "provider" => "gds", "uid" => "abcde",
        "credentials" => {
          "token" => "123456",
          "refresh_token" => "1a2b3c4d"
        },
        "user_info" => {
          "name" => "Matt Patterson", "email" => "matt@alphagov.co.uk"
        },
        "extra" => {
          "user_hash" => {
            "email" => "matt@alphagov.co.uk", "github" => nil,
            "name" => "Matt Patterson", "twitter" => nil,
            "uid" => "abcde",
            "version" => 1
          }
        }
      }
    end

    describe "finding a User" do
      it "returns an existing User if it finds one with the right UID" do
        User.expects(:find_by_uid).with("abcde").returns(:user)

        User.find_for_gds_oauth(@auth_hash)
      end

      it "creates a new User if it can't find one" do
        User.expects(:find_by_uid).with("abcde").returns(nil)
        User.expects(:create_from_auth_hash).with(@auth_hash).returns(:created_user)

        User.find_for_gds_oauth(@auth_hash).should == :created_user
      end
    end

    describe "creating a user" do
      it "correctly creates a user" do
        User.expects(:create!).with("email" => "matt@alphagov.co.uk", "uid" => "abcde", "name" => "Matt Patterson", "version" => 1).returns(:user)

        User.create_from_auth_hash(@auth_hash).should == :user
      end
    end
  end
end
