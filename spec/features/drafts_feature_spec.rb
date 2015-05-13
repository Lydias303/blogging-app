require 'rails_helper'

describe "drafts index", :type => :feature do
  before :each do
    post = create(:post, status: 'draft')
    visit '/drafts'
  end

  it "only displays drafts" do
    published_post = create(:post, status: 'published', title: 'Im published!')
    expect(page).to have_content('Draft Posts')

    within(".title") do
      expect(page).to have_content('My Post')
      expect(page).to_not have_content('Im published!')
    end
  end

  it "a draft can be created using mark down" do
    visit '/'

    within(".new_post") do
      fill_in 'Title', with: 'New Post'
      fill_in 'Body', with: '#### This is an H4'
      fill_in 'Author', with: 'Bro'
      click_button 'New Post'
    end
    expect(page).to have_content('Post Created!')

    within('h4') do
      expect(page).to have_content('This is an H4')
    end
  end
end

describe "drafts show", :type => :feature do
  before :each do
    post = create(:post, status: 'draft')
    visit draft_path(post)
  end

  it "can publish a draft" do
    click_link_or_button 'Publish'

    expect(current_path).to eq('/')
    expect(page).to have_content('Post has been published!')
  end

  it "can delete a draft on the draft post show page" do
    page.find('.delete-button').click
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Post Deleted!')
  end

  it "can edit a draft post" do
    blog_post = create(:post, status: 'draft')
    visit draft_path(blog_post)

    click_link_or_button 'Edit'
    expect(current_path).to eq(edit_post_path(blog_post))

    within(".post-edit-form") do
      fill_in 'Title', with: 'New Title'
      fill_in 'Author', with: 'HEYO'
      click_button 'Update Post'
    end
    expect(page).to have_content('Post Updated!')
    expect(current_path).to eq(draft_path(blog_post))
  end

  it "can delete a draft post" do
    expect(Post.count).to eq(1)

    page.find('.delete-button').click

    expect(current_path).to eq('/')
    expect(Post.count).to eq(0)
  end

  it "will error if it cannot be updated" do
    blog_post = create(:post, status: 'draft')
    visit edit_post_path(blog_post)

    within(".post-edit-form") do
      fill_in 'Title', with: ''
      fill_in 'Author', with: 'HEYO'
      click_button 'Update Post'
    end
    expect(page).to have_content('Unable to update Post!')
    expect(current_path).to eq('/')
  end
end
