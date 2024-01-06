class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[ show edit update destroy ]

  def index
    @line_items = LineItem.all
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    @line_item = LineItem.new(line_item_params)

      if @line_item.save
        redirect_to line_item_url(@line_item), notice: "Line item was successfully created."
      else
        render :new
      end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to line_item_url(@line_item), notice: "Line item was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @line_item.destroy!
    redirect_to line_items_url, notice: "Line item was successfully destroyed."
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:quantity, :product_id, :cart_id, :customer_id)
    end
end
