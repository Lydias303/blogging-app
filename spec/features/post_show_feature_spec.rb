
describe "posts show", :type => :feature do
  before :each do
    post = create(:post)
    visit post_path(post)
  end

  it "can go to a post show" do
    newpost = create(:post, title: 'new')
    visit '/'
    click_link_or_button 'new'

    expect(current_path).to eq(post_path(newpost))
  end

  it "can change status back to draft" do

    expect(page).to have_content('My Post')

    click_link_or_button 'Mark as Draft'
    expect(current_path).to eq(drafts_path)
    expect(page).to have_content('Post has been reverted to draft')
  end

  it "can edit a published post" do
    blog_post = create(:post)
    visit post_path(blog_post)

    click_link_or_button 'Edit'
    expect(current_path).to eq(edit_post_path(blog_post))

    within(".post-edit-form") do
      fill_in 'Title', with: 'New Title'
      fill_in 'Body', with: 'Oh hi'
      click_button 'Update Post'
    end
    expect(page).to have_content('Post Updated!')
    expect(current_path).to eq(draft_path(blog_post))
    expect(page).to have_content("New Title")
  end

  it "changed the status back to draft after update" do
    blog_post = create(:post)
    visit (edit_post_path(blog_post))

    within(".post-edit-form") do
      fill_in 'Title', with: 'This will change my status'
      click_button 'Update Post'
    end
    expect(Post.last.status).to eq('draft')
    expect(Post.last.title).to eq('This will change my status')
  end

  it "can delete a published post" do
    expect(Post.count).to eq(1)

    click_link_or_button 'Delete'

    expect(current_path).to eq('/')
    expect(Post.count).to eq(0)
  end
end
