class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities_feed = current_user.feed.recent.paginate page: params[:page]
    end
  end
end
