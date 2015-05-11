class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post Created!"
      redirect_to root_path
    else
      flash[:error] = "Unable to create Post!"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :author, :body)
  end
end
