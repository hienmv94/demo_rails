class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_entry, only: [:create]
  before_action :correct_user, only: [:destroy]

  def create
    @comment = @entry.comments.build(comment_params) do |c|
      c.user = current_user
    end
    if @comment.save
      respond_to do |format|
        format.html do 
          flash[:success] = "New comment is created."
          redirect_to request.referrer || root_url 
        end
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @entry_id = @comment.entry_id
    if @comment.destroy
      respond_to do |format|
        format.html do     
          flash[:success] = "entry deleted"
          redirect_to request.referrer || root_url
        end
        format.js { @entry_id }
      end
    else
      flash.now[:danger] = "Error"
    end
  end

  private
    def comment_params
      # params.require(:comment).permit(:entry_id, :content)
      params.require(:comment).permit(:content)
    end
    def set_entry
      @entry = Entry.find(params[:entry_id])
    end
    def correct_user
      @comment = Comment.find(params[:id])
      current_user == @comment.user 
    end
end
