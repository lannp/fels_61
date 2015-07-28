class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities_feed = current_user.feed.recent.paginate page: params[:page]
      @results = Result.results_by_user current_user.lessons.pluck(:id)
    end
  end
end
