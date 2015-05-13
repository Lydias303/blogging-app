module PostsHelper
  def save_tags(tags, post)
    tags.reject(&:empty?).each do |tag|
      post.tags << Tag.find(tag)
    end
  end
end
