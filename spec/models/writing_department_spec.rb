require 'spec_helper'

describe WritingDepartment do
  describe "associations" do
    it { should have_many(:needs) }
  end
end
