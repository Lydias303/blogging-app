class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    if @post && @comment.save
      @post.comments << @comment
      flash[:notice] = "Your Comment Has Been Added"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Unable to add Comment"
      redirect_to post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
