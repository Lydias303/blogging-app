class TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "Tag Created!"
      redirect_to tags_path
    else
      flash[:error] = "Unable to create Tag!"
      redirect_to tags_path
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    
    flash[:notice] = "Tag Removed!"
    redirect_to :back
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
