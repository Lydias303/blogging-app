class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.published
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post Created!"
      redirect_to draft_path(@post)
    else
      flash[:error] = "Unable to create Post!"
      redirect_to root_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
       @post.update_attribute(:status, 'draft')
       flash[:notice] = "Post Updated!"
       redirect_to draft_path(@post)
    else
      flash[:error] = "Unable to update Post!"
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Post Deleted!"
      redirect_to root_path
    else
      flash[:error] = "Unable to delete Post!"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :author, :body)
  end
end
