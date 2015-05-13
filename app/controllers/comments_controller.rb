class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    respond_to do |format|
    if @post && @comment.save
      @post.comments << @comment
      format.html { redirect_to post_path(@post), notice: 'Your Comment Has Been Added'}
      format.js   {}
      format.json { render json: @comment, status: :created, location: @comment}
    else
      flash[:notice] = "Unable to add Comment"
      redirect_to post_path(@post)
    end
  end
end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    flash[:notice] = "Comment Has been Deleted"
    redirect_to :back
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(comment_params)
      flash[:notice] = "Comment Updated!"
      redirect_to post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
