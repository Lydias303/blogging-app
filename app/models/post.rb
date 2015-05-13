class Post < ActiveRecord::Base
  has_many          :comments, dependent: :destroy
  has_many          :posts_tags
  has_many          :tags, :through => :posts_tags
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :title, :author, :body, presence: true
  validates :status, inclusion: { in: %w(published draft)}

  scope :published, -> {where(status: 'published')}
  scope :draft, -> {where(status: 'draft')}
end
