class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    last_cart = Cart.find(current_cart.id)
    items = current_cart.line_items.map(&:item_id)
    quantities_array = current_cart.line_items.map(&:quantity)
    items.zip(quantities_array).each{|item_id, quantity| item = Item.find(item_id); item.inventory -= quantity; item.save}
    current_cart.update(status: "submitted")
    current_user.current_cart = nil
    redirect_to cart_path(last_cart)
  end
end
