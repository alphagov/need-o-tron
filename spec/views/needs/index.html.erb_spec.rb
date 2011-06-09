require 'spec_helper'

describe "needs/index.html.erb" do
  before(:each) do
    assign(:needs, [
      stub_model(Need),
      stub_model(Need)
    ])
  end

  it "renders a list of needs" do
    render
  end
end
