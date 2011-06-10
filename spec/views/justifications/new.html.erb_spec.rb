require 'spec_helper'

describe "justifications/new.html.erb" do
  before(:each) do
    assign(:justification, stub_model(Justification).as_new_record)
  end

  it "renders new justification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => justifications_path, :method => "post" do
    end
  end
end
