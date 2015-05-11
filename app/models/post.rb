class Post < ActiveRecord::Base
  validates :title, :author, :body, presence: true
  validates :status, inclusion: { in: %w(published draft)}

  scope :published, -> {where(status: 'published')}
  scope :draft, -> {where(status: 'draft')}
end
