require_relative 'acceptance_helper'

describe "Managing sources to a need" do
  before(:each) do
    @user = FactoryGirl.create(:admin_user)
    @need = FactoryGirl.create(:need, :title => "Apply for a premises licence", :description => "As a business owner, I want to apply for a premises licence from my local council.")
  end

  describe "adding a source" do
    before(:each) do
      visit "/needs/#{@need.id}"
      click_on "Add a new source"
    end

    it "correctly displays the form" do
      page.should have_selector("h1", :text => "Add source")

      page.should have_field("Title")
      page.should have_select("Kind", :with_options => ["Directgov", "Existing service"])
      page.should have_field("URL")
      page.should have_field("Notes")

      page.should have_button("Create Source")
      page.should have_no_link("Delete this source")
    end

    it "displays errors for an invalid source" do
      fill_in "Title", :with => "An important source"
      select "", :from => "Kind"
      click_on "Create Source"

      page.should have_selector("h1", :text => "Add source")
      within("#error_explanation") do
        page.should have_content("Kind can't be blank")
        page.should have_content("Kind is not included in the list")
      end
    end

    it "saves and redirects to the need given a valid source" do
      fill_in "Title", :with => "An important source"
      select "Existing service", :from => "Kind"
      click_on "Create Source"

      within("p.notice") do
        page.should have_content("Source was successfully created")
      end

      within("#need-details") do
        page.should have_content("An important source")
      end
    end
  end


end
