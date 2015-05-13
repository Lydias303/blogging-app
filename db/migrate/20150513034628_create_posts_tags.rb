class CreatePostsTags < ActiveRecord::Migration
  def change
    create_table :posts_tags do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
      t.timestamps null: false
    end
  end
end
