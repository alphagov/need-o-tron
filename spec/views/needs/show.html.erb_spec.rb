require 'spec_helper'

describe "needs/show.html.erb" do
  before(:each) do
    @need = assign(:need, stub_model(Need))
  end

  it "renders attributes in <p>" do
    render
  end
end
