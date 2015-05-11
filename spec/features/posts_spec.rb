require 'rails_helper'

describe "posts index", :type => :feature do
  before :each do
    post = create(:post)
  end

  it "has all posts displayed on index" do
    visit '/'
    expect(page).to have_content('Blog Posts')

    within(".body") do
      expect(page).to have_content('This is a post!')
    end

    within(".title") do
      expect(page).to have_content('My Post')
    end
  end

  it "can create a new post" do
    visit '/'

    within(".post-form") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: 'Nice Bod'
      fill_in 'Author', with: 'Bro'
      click_button 'New Post'
    end
    expect(page).to have_content("Post Created!")
  end

  it "wont create a new post with missing params" do
    visit '/'

    within(".post-form") do
      fill_in 'Title', with: ''
      fill_in 'Body', with: 'Heyyo'
      fill_in 'Author', with: ''
      click_button 'New Post'
    end
    expect(page).to have_content("Unable to create Post!")
  end

  it "only shows published posts on the main page" do
    visit '/'

    draft_post = create(:post, title: "Im not published!", status: "draft")

    within(".title") do
      expect(page).to_not have_content("Im not published!")
      expect(page).to have_content("My Post")
    end
  end

  xit "can display a published post created with markdown" do
    visit '/'

    within(".post-form") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: '## This is an H2'
      fill_in 'Author', with: 'Bro'
      click_button 'New Post'
    end

    expect(page).to have_content('Post Created!')
    expect(current_path).to eq('/draft')
    within('h2') do
      expect(page).to have_content('This is an H2')
    end
  end
end
