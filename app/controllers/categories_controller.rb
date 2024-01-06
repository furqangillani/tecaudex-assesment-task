class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_vendor_role
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_url(@category), notice: "Category was successfully created."
    else
      render :new
    end
  end

  def update
      if @category.update(category_params)
        redirect_to category_url(@category), notice: "Category was successfully updated."
      else
        render :edit
      end
  end

  def destroy
    @category.destroy!
    redirect_to categories_url, notice: "Category was successfully destroyed."
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end

    def check_vendor_role
      unless current_user.has_role?(:vendor)
        redirect_to root_path, alert: 'Access denied!'
      end
    end
end
