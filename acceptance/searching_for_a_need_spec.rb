require_relative 'acceptance_helper'

describe 'Searching for a need' do
  before :each do
    u = User.new(uid: "ABC", name: "T Est", email: "test@example.com", version: 1)
    u.is_admin = true
    u.save!
  end

  def create_need name, other_fields = {}
    visit "/"
    click_link "Enter a new need"
    fill_in "Need", with: name
    #TODO
    other_fields
    click_button "Create Need"
  end

  def search_for text
    fill_in "Search", with: text
    click_button "Search"
  end

  it 'works when searching by title' do
    create_need "Replace passport"

    click_link "Browse/search"

    search_for 'Replace passport'
    page.should have_css "#needs-table", text: 'Replace passport'

    search_for "Missing"
    page.should have_content "Nothing found"
  end

  it 'works when accessed by lead department' do
    department = create_department "Ministry of Truth"
    create_need "Get a new passport", "Department" => "Ministry of Truth"
    create_need "Get a new driving licence"
  end
end