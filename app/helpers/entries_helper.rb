module EntriesHelper
  def all_feed
    @entries = Entry.all.paginate(page: params[:page]) 
  end
end
