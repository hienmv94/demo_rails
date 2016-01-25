class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_entry, only: [:create, :destroy]

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
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
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
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
