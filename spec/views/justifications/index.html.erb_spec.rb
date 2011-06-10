require 'spec_helper'

describe "justifications/index.html.erb" do
  before(:each) do
    assign(:justifications, [
      stub_model(Justification),
      stub_model(Justification)
    ])
  end

  it "renders a list of justifications" do
    render
  end
end
