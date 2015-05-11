class Post < ActiveRecord::Base
  validates :title, :author, :body, presence: true
  validates :status, inclusion: { in: %w(published draft)}
end
