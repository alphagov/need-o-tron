require 'spec_helper'

describe Contact do
  describe "associations" do
    it { should have_many(:fact_checkers) }
  end
end
