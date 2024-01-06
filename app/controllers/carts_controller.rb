class CartsController < ApplicationController

  def add_to_cart
     product = Product.find_by(id: params[:id])
     if product.present?
      order = Order.current_order
      order.save!
      order.add_product(product, 1)
      flash[:notice] = "Added to cart successfully"
      redirect_to root_path
     else
       flash[:notice] = "Product Not Found"
      redirect_to root_path
     end
  end

  def view_cart
    @order = Order.current_order || Order.find_by(id: params["id"])
    @order.re_calculate_order
    @cart_items = @order.cart_items
  end

  def complete_order
     order = Order.current_order
     order.order_completed
     flash[:notice] = "Order has been completed successfully"
      redirect_to root_path
  end


  def delete_order
    order = Order.current_order
    if order.present?
      order.destroy
    end
    redirect_to root_path, notice: "Cart was successfully destroyed."
  end

end
