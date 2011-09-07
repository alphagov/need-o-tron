require 'spec_helper'

describe Accountability do
  describe "associations" do
    it { should belong_to(:department) }
    it { should belong_to(:need) }
  end
end
