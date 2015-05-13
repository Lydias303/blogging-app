require 'rails_helper'

describe "posts index", :type => :feature do
  before :each do
    post = create(:post)
    visit '/'
  end

  it "has all posts displayed on index" do
    expect(page).to have_content('Blog Posts')

    within(".post-body") do
      expect(page).to have_content('This is a post!')
    end

    within(".title") do
      expect(page).to have_content('My Post')
    end
  end

  it "can create a new post" do
    tag = create(:tag)
    visit '/'

    within(".post-form") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: 'Nice Bod'
      fill_in 'Author', with: 'Bro'
      select(tag.name, :from => 'Tags')
      click_button 'New Post'
    end
    expect(page).to have_content("Post Created!")
  end

  it "wont create a new post with missing params" do

    within(".post-form") do
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

    within(".post-form") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: '##### This is an H5'
      fill_in 'Author', with: 'Bro'
      click_button 'New Post'
    end

    expect(page).to have_content('Post Created!')

    within('.publish-button') do
      click_link_or_button 'Publish Post'
    end

    expect(current_path).to eq('/')

    within('h5') do
      expect(page).to have_content('This is an H5')
    end
  end
end
