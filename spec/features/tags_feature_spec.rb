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

  it 'cannot create a tag when name is blank' do
    within('.tag-create') do
      fill_in 'Name', with: ' '
      click_button 'Create Tag'
    end
    expect(page).to have_content('Unable to create Tag!')
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

  it 'can display tags on the index page' do
    tag = create(:tag)
    second_tag = create(:tag, name: 'new tag')

    visit tags_path

    expect(page).to have_content(tag.name)
    expect(page).to have_content(second_tag.name)
  end
end
