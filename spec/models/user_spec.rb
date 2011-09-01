require 'spec_helper'

describe User do
  it "is not marked as an admin by default" do
    User.new.is_admin?.should be_false
  end
end
