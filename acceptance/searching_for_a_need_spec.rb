require_relative 'acceptance_helper'

describe 'Searching for a need' do
  it 'works' do
    u = User.new(uid: "ABC", name: "T Est", email: "test@example.com", version: 1)
    u.is_admin = true
    u.save!
    visit "/"
    click_link "Enter a new need"
    fill_in "Need", with: "Replace passport"
    click_button "Create Need"
    click_link "Browse/search"
    fill_in "Search", with: "Replace"
    click_button "Search"
    page.should have_css "#needs-table", text: 'Replace passport'
    fill_in "Search", with: "Missing"
    click_button "Search"
    page.should have_content "Nothing found"
  end
end