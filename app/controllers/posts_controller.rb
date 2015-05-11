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

  private

  def post_params
    params.require(:post).permit(:title, :author, :body)
  end
end
