class Comment < ActiveRecord::Base
  belongs_to :post

  validates :author_name, :body, presence: true
end
