require 'spec_helper'

describe FactChecker do
  describe "associations" do
    it { should belong_to(:contact) }
    it { should belong_to(:need) }
  end
end
