class Admin::WordsController < ApplicationController
  before_action :init_word, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    @words = Word.all
    @word = Word.new
    4.times do
      @answer = @word.answers.build
    end
  end

  def create
    @word = Word.new word_params
    if @word.save
      respond_to do |format|
        format.html do
          flash[:info] = t "create_word_success_message"
          redirect_to admin_words_path
        end
        format.js
      end
    else
      flash[:now] = t "create_word_failed_message"
      redirect_to admin_words_path
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:sucess] = t "update_sucessfull_message"
      redirect_to admin_words_path
    else
      render :edit
      flash.now[:danger] = t "update_failed_message"
    end
  end

  def destroy
    if @word.destroy
      respond_to do |format|
        format.html do
          flash[:info] = t "destroy_word_success_message"
          redirect_to admin_words_path
        end
        format.js
      end
    else
      flash[:now] = t "destroy_word_failed_message"
    end
  end
  
  private
  def init_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :content, :category_id, answers_attributes: [:id, :content, :status]
  end
end
