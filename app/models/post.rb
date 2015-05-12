class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :title, :author, :body, presence: true
  validates :status, inclusion: { in: %w(published draft)}

  scope :published, -> {where(status: 'published')}
  scope :draft, -> {where(status: 'draft')}
end
