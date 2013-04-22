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
      page.should have_select("Kind", :with_options => ["Legacy service", "Existing service"])
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

      within(".alert") do
        page.should have_content("Source was successfully created")
      end

      within(".sources") do
        page.should have_content("An important source")
      end
    end
  end

  context "when a source exists" do
    before(:each) do
      @need.sources.create!(:kind => 'existing_service', :title => 'Local authority online tools', :url => "http://something.gov.uk/")
    end

    it "shows the source in the list" do
      visit "/needs/#{@need.id}"

      within(".sources li:first-child") do
        page.should have_content("Existing service")
        page.should have_content("Local authority online tools")
        page.should have_link("http://something.gov.uk/", :href => "http://something.gov.uk/")

        page.should have_link("edit", :href => "/needs/#{@need.id}/sources/#{@need.sources.first.id}/edit")
      end
    end

    describe "editing a source" do
      before(:each) do
        visit "/needs/#{@need.id}"

        within(".sources li:first-child") do
          click_on "edit"
        end
      end

      it "displays the edit form for the source" do
        page.should have_selector("h1", :text => "Edit source")

        page.should have_field("Title", :with => "Local authority online tools")
        page.should have_select("Kind", :with_options => ["Legacy service", "Existing service"], :selected => "Existing service")
        page.should have_field("URL", :with => "http://something.gov.uk/")
        page.should have_field("Notes")

        page.should have_button("Update Source")
        page.should have_link("Delete this source")
      end

      it "displays errors for an invalid source" do
        select "", :from => "Kind"
        click_on "Update Source"

        page.should have_selector("h1", :text => "Edit source")
        within("#error_explanation") do
          page.should have_content("Kind can't be blank")
          page.should have_content("Kind is not included in the list")
        end
      end

      it "saves and redirects to the need given a valid source" do
        fill_in "Title", :with => "Local authority single tool"
        select "Legacy service", :from => "Kind"
        click_on "Update Source"

        within(".alert") do
          page.should have_content("Source was successfully updated")
        end

        within(".sources li:first-child") do
          page.should have_content("Legacy service")
          page.should have_content("Local authority single tool")
        end
      end
    end

    it "can delete the source and redirects back to the need" do
      visit "/needs/#{@need.id}"

      within(".sources li:first-child") do
        click_on "edit"
      end
      click_on "Delete this source"

      within(".alert") do
        page.should have_content("Source was successfully destroyed")
      end

      within(".sources") do
        page.should have_no_selector("li")
      end
    end
  end

end
