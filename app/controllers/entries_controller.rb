class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

    
  def create
    @entry = current_user.entries.build(entry_params)
    @entry.save
    flash.now[:success] = "New entry is created."
    @entries = current_user.feed.paginate(page: params[:page])
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    flash.now[:success] = "entry deleted"
    @entries = current_user.feed.paginate(page: params[:page])
  end

  private
    def entry_params
      params.require(:entry).permit(:title, :content)
    end
    def correct_user
      @entry =  @entry = Entry.find(params[:id])
      current_user == @entry.user
    end
end
