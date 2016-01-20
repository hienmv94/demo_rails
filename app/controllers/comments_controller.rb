class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = "New comment is created."
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url # redirect to previous pages before delete post or root pages

  end

  private
    def comment_params
      params.require(:comment).permit(:entry_id, :content)
    end
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
