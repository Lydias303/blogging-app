class DraftController < ApplicationController

  def index
    @posts = Post.draft
  end
end
