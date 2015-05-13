class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.published
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      params[:post][:tags].reject(&:empty?).each do |tag|
        @post.tags << Tag.find(tag)
      end
      flash[:notice] = "Post Created!"
      redirect_to draft_path(@post)
    else
      flash[:error] = "Unable to create Post!"
      redirect_to root_path
    end
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    @comments = @post.comments.all
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
    @post.destroy
    flash[:notice] = "Post Deleted!"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :author, :body, :avatar, :tags)
  end
end
