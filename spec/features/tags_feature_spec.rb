require 'rails_helper'

describe 'tags index', :type => :feature do
  before :each do
    visit tags_path
  end

  it 'can create a tag on the tag index' do
    within('.tag-create') do
      fill_in 'Name', with: 'Bears'
      click_button 'Create Tag'
    end
    expect(page).to have_content('Tag Created!')
  end

  it 'can delete a tag' do
    tag = create(:tag)
    visit tags_path
    expect(Tag.count).to eq(1)

    within('.tag-index') do
      click_link_or_button 'Delete'
    end

    expect(Tag.count).to eq(0)
  end

  xit "can delete a comment" do
    post = create(:post)
    comment = create(:comment, post_id: post.id)
      visit post_path(post)
    expect(Comment.count).to eq(1)

    click_link_or_button 'Delete Comment'

    expect(Comment.count).to eq(0)
  end
end
