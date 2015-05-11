require 'rails_helper'

describe "drafts index", :type => :feature do
  before :each do
    post = create(:post, status: 'draft')
  end

  it "only displays drafts" do
    visit '/drafts'
    published_post = create(:post, status: 'published', title: 'Im published!')
    expect(page).to have_content('Draft Posts')

    within(".title") do
      expect(page).to have_content('My Post')
      expect(page).to_not have_content('Im published!')
    end
  end

  it "a draft can be created using mark down" do
    visit '/'

    within(".post-form") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: '##### This is an H5'
      fill_in 'Author', with: 'Bro'
      click_button 'New Post'
    end
    expect(page).to have_content('Post Created!')

    within('h5') do
      expect(page).to have_content('This is an H5')
    end
  end
end
