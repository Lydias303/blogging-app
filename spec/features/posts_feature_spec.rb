require 'rails_helper'

describe "posts index", :type => :feature do
  before :each do
    post = create(:post)
    visit '/'
  end

  it "has all posts displayed on index" do
    expect(page).to have_content('Blog Posts')

    within(".title") do
      expect(page).to have_content('My Post')
    end
  end

  it "can create a new post" do
    tag = create(:tag)
    visit '/'

    within(".new_post") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: 'Nice Bod'
      fill_in 'Author', with: 'Bro'
      select(tag.name, :from => 'Tags')
      click_button 'New Post'
    end
    expect(page).to have_content("Post Created!")
  end

  it "wont create a new post with missing params" do

    within(".new_post") do
      fill_in 'Title', with: ''
      fill_in 'Body', with: 'Heyyo'
      fill_in 'Author', with: ''
      click_button 'New Post'
    end
    expect(page).to have_content("Unable to create Post!")
  end

  it "only shows published posts on the main page" do

    draft_post = create(:post, title: "Im not published!", status: "draft")

    within(".title") do
      expect(page).to_not have_content("Im not published!")
      expect(page).to have_content("My Post")
    end
  end

  it "can display a published post created with markdown" do

    within(".new_post") do
      fill_in 'Title', with: 'Title'
      fill_in 'Body', with: '###### This is an H6'
      fill_in 'Author', with: 'Bro'
      click_button 'New Post'
    end

    expect(page).to have_content('Post Created!')

    page.find('.publish-button').click

    expect(current_path).to eq('/')

    click_link_or_button('Title')

    within('h6') do
      expect(page).to have_content('This is an H6')
    end
  end
end
