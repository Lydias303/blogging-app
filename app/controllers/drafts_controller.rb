class DraftsController < ApplicationController
  def index
    @posts = Post.draft
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @post.update_attribute(:status, 'published')

    flash[:notice] = "Post has been published!"
    redirect_to root_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.update_attribute(:status, 'draft')

    flash[:notice] = "Post has been reverted to draft"
    redirect_to drafts_path
  end
end
