require 'spec_helper'

describe "needs/edit.html.erb" do
  before(:each) do
    @need = assign(:need, stub_model(Need))
  end

  it "renders the edit need form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => needs_path(@need), :method => "post" do
    end
  end
end
