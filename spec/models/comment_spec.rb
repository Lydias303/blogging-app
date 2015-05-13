require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'validates a full comment' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'is not valid without a body' do
    comment = build(:comment, body: '')
    expect(comment).to_not be_valid
  end

  it 'is not valid without an author name' do
    comment = build(:comment, author_name: '')
    expect(comment).to_not be_valid
  end

  it 'belongs to a post' do
    post = create(:post)
    comment = create(:comment)
    post.comments << comment
    expect(comment.post_id).to eq(post.id)
    expect(post.comments.first).to eq(comment)
  end
end
