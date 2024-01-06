class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_vendor_role
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
    @vendors = Vendor.all
    @categories = Category.all
  end

  def edit
    @vendors = Vendor.all
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_url(@product), notice: "Product was successfully created."
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_url(@product), notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy!
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :vendor_id)
    end

  def check_vendor_role
    unless current_user.has_role?(:vendor)
      redirect_to root_path, alert: 'Access denied!'
    end
  end

end
