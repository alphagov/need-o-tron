require 'spec_helper'

describe Department do
  describe "associations" do
    it { should have_many(:accountabilities) }
  end
end
