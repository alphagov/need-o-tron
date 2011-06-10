require 'spec_helper'

describe "justifications/edit.html.erb" do
  before(:each) do
    @justification = assign(:justification, stub_model(Justification))
  end

  it "renders the edit justification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => justifications_path(@justification), :method => "post" do
    end
  end
end
