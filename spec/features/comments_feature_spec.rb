require 'rails_helper'

describe "comments", :type => :feature do
  before :each do
    post = create(:post)
    visit post_path(post)
  end

  it "can create a comment on a post show page" do
    within(".comment-create") do
      fill_in 'Body', with: 'Jolly Good Blog Post'
      fill_in 'Author name', with: 'Mr. Hat'
      click_button 'Add Comment'
    end
    expect(page).to have_content('Your Comment Has Been Added')
  end

  it "cannot create a comment with blank fields" do
    within(".comment-create") do
      fill_in 'Body', with: 'Jolly Good Blog Post'
      fill_in 'Author name', with: ' '
      click_button 'Add Comment'
    end
    expect(page).to have_content('Unable to add Comment')
  end

  it "can create a comment on a post show page with markdown" do
    within(".comment-create") do
      fill_in 'Body', with: '###### This is an H6'
      fill_in 'Author name', with: 'Miss Lady'
      click_button 'Add Comment'
    end
    expect(page).to have_content('Your Comment Has Been Added')
    within('h6') do
      expect(page).to have_content('This is an H6')
    end
  end

  it "can delete a comment" do
    post = create(:post)
    comment = create(:comment, post_id: post.id)
      visit post_path(post)
    expect(Comment.count).to eq(1)

    click_link_or_button 'Delete Comment'

    expect(Comment.count).to eq(0)
  end

  it "can take the user to an edit comment page" do
    post = create(:post)
    comment = create(:comment, post_id: post.id)
      visit post_path(post)
    expect(Comment.count).to eq(1)

    click_link_or_button 'Edit Comment'

    expect(current_path).to eq(edit_post_comment_path(post, comment))
  end


    it "can take the user to an edit comment page" do
      post = create(:post)
      comment = create(:comment, post_id: post.id)

      visit (edit_post_comment_path(post, comment))
      within(".edit-comment") do
        fill_in 'Body', with: 'I like it'
        fill_in 'Author name', with: 'Miss Lady'
        click_button 'Update Comment'
      end

      expect(current_path).to eq(post_path(post))
      expect(page).to have_content('I like it')
      expect(page).to have_content('Comment Updated!')
    end
end
