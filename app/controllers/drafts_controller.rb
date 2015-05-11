class DraftsController < ApplicationController

  def index
    @posts = Post.draft
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    if @post.update_attribute(:status, 'published')
      flash[:notice] = "Post has been published!"
      redirect_to root_path
    else
      flash[:error] = "Unable to Publish Post!"
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.update_attribute(:status, 'draft')
      flash[:notice] = "Post has been reverted to draft"
      redirect_to drafts_path
    else
      flash[:error] = "Unable to revert post to draft"
      redirect_to root_path
    end
  end
end
