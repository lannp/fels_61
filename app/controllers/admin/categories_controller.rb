class Admin::CategoriesController < ApplicationController
  before_action :init_category, except: [:new, :index, :create]

  def index
    @categories = Category.ordered_by_create_at.paginate page: params[:page], per_page: Settings.per_page
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_category_success_message"
    else
      flash[:success] = t "create_category_failed_message"
    end
    redirect_to admin_categories_path
  end
  
  def destroy
    if @category.destroy
      flash[:success] = t "destroy_category_success_message"
      redirect_to admin_categories_path
    else
      flash[:success] = t "destroy_category_unsuccess_message"
      redirect_to admin_categories_path
    end
  end

  private
  def init_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
