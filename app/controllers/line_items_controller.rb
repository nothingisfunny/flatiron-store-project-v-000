class LineItemsController < ApplicationController
  def create
    unless current_cart
      current_user.current_cart = Cart.create(user_id: current_user.id)
    end
    line_item = current_cart.add_item(params[:item_id])
    line_item.save
    redirect_to cart_path(current_cart)
  end
end
