require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Post" do
    it "validates a full post" do
      post = build(:post)
      expect(post).to be_valid
    end

    it "is not valid without a title" do
      post = build(:post, title: "")
      expect(post).to_not be_valid
    end

    it "is not valid without an author" do
      post = build(:post, author: "")
      expect(post).to_not be_valid
    end

    it "is not valid without a body" do
      post = build(:post, body: "")
      expect(post).to_not be_valid
    end

    it "can have a status of published" do
      post = build(:post, status: "published")
      expect(post).to be_valid
    end

    it "can have a status of draft" do
      post = build(:post, status: "draft")
      expect(post).to be_valid
    end

    it "is invalid with any status other than published or draft" do
      post = build(:post, status: "in progress")
      second_post = build(:post, status: "completed")
      expect(post).to_not be_valid
      expect(second_post).to_not be_valid
    end

    it "has a tag printer helper method" do
      tag = create(:tag, name: 'food')
      tag2 = create(:tag, name: 'drink')
      post = create(:post)

      post.tags << tag
      post.tags << tag2

      expect(post.print_tags).to eq('food, drink')
    end
  end
end
