require_relative 'acceptance_helper'

describe 'Searching for a need' do
  before :each do
    u = User.new(uid: "ABC", name: "T Est", email: "test@example.com", version: 1)
    u.is_admin = true
    u.save!
  end

  def create_need name, options = {}
    visit "/"
    click_link "Enter a new need"
    fill_in "Need", with: name
    fill_in "Tags", with: options[:tags] if options.has_key?(:tags)
    click_button "Create Need"             
    if options.has_key?(:edit_form_fields)
      click_link 'Edit'                    
      options[:edit_form_fields].each do |field, value|
        (field == 'Writing team') ? select(value, from: field) : fill_in(field, with: value)
      end
      click_link_or_button "Update Need"
    end
  end

  def search_for text
    fill_in "Search", with: text
    click_button "Search"
  end

  it 'works when searching by title' do
    create_need "Replace passport"

    click_link "View all needs"

    search_for 'Replace passport'
    page.should have_css "#needs-table", text: 'Replace passport'

    search_for "Missing"
    page.should have_content "Nothing found"
  end

  it 'works when searching for a word from the Writing department field' do        
    WritingDepartment.create name: "Ministry of Truth"     
    create_need "Get a new passport", edit_form_fields: { "Writing team" => "Ministry of Truth"}
    create_need "Get a new driving licence"
    click_link "View all needs"
    search_for 'Truth'
    within '#needs-table' do
      page.should have_content 'Get a new passport'
      page.should have_no_content 'Get a new driving license'
    end                
  end

  it 'allows filtering by facets' do
    create_need "Get a new passport", tags: "red"
    create_need "Learn to drive", tags: "blue"

    click_link "View all needs"
    click_link "red"
    within '#needs-table' do
      page.should have_content 'Get a new passport'
      page.should have_no_content 'Learn to drive'
    end

    click_link "View all needs"
    click_link "blue"
    within '#needs-table' do
      page.should have_no_content 'Get a new passport'
      page.should have_content 'Learn to drive'
    end
  end

  it 'allows filtering by a combination of facets' do
    create_need "Get a new passport", tags: "red,blue"
    create_need "Learn to drive", tags: "blue"
    create_need "Learn to walk", tags: "red"

    click_link "View all needs"
    click_link "blue"
    click_link "red"
    within '#needs-table' do
      page.should have_content 'Get a new passport'
      page.should have_no_content 'Learn to drive'
      page.should have_no_content 'Learn to walk'
    end
  end

  it 'allows pagination' do
    11.upto(25) do |i|
      Need.create(title: "Need #{i}")
    end
    visit "/?per_page=10"
    within '#needs-table' do
      page.should have_no_content 'Need 21'
    end
    within '.pagination' do
      click_link "2"
    end
    within '#needs-table' do
      page.should have_no_content 'Need 20'
      page.should have_content 'Need 21'
    end
  end

  it 'allows sorting, defaults to Title asc' do
    create_need "Apples"
    create_need "Carrots"
    create_need "Bananas"
    visit "/"
    page.should have_css "#needs-table th.sorting-asc", "Title"
    within '#needs-table' do
      page.text.should =~ /Apples.*Bananas.*Carrots/m
    end
    click_link "Title"
    within '#needs-table' do
      page.text.should =~ /Carrots.*Bananas.*Apples/m
    end
  end

end