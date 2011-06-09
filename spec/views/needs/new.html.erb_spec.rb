require 'spec_helper'

describe "needs/new.html.erb" do
  before(:each) do
    assign(:need, stub_model(Need).as_new_record)
  end

  it "renders new need form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => needs_path, :method => "post" do
    end
  end
end
