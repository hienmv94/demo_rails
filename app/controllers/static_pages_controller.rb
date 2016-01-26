class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @all_feeds = all_feed
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def bootstrap # demo bootstrap
  end
end
