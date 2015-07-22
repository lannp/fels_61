class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories= Category.all
    if params[:filter_state]
      @words = Word.of_category(params[:category_id]).send(params[:filter_state], current_user.id)
        .paginate page: params[:page]
    else
      @words = Word.of_category(params[:category_id]).paginate page: params[:page]
    end
  end
end
