require 'spec_helper'

describe "justifications/show.html.erb" do
  before(:each) do
    @justification = assign(:justification, stub_model(Justification))
  end

  it "renders attributes in <p>" do
    render
  end
end
