class LessonsController < ApplicationController
  before_action :init_lesson, only: [:show, :edit, :update]

  def index
    @lessons = current_user.lessons
  end

  def show 
    @results = Lesson.find(params[:id]).results
  end

  def edit
    
  end
  
  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "lesson.success"
      redirect_to edit_lesson_path @lesson
    else
      flash.now[:danger] = t "lesson.fail"
      redirect_to categories_path
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.finished"
      redirect_to @lesson
    else
      flash.now[:danger] = t "error"
      render "edit"
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, results_attributes: [:id, :status, :word_id]
  end

  def init_lesson
    @lesson = Lesson.find params[:id]
  end
end
