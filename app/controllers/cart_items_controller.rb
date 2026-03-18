class CartItemsController < ApplicationController
  before_action :authenticate_user!
def create
  cart = current_user.cart || current_user.create_cart

  item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id], variant_id: params[:variant_id])
  item.quantity ||= 0
  item.quantity += 1
  item.product = Product.find(params[:product_id])
  item.variant = Variant.find(params[:variant_id])
  item.save!
  redirect_to cart_path
end

  def destroy
    current_user.cart.cart_items.find(params[:id]).destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  def increase
    item = CartItem.find(params[:id])
    if item.variant.stock > item.quantity
      item.increment!(:quantity)
    else
      flash[:alert] = "Não há estoque suficiente para aumentar a quantidade."
    end
    redirect_to cart_path
  end

  def decrease
    item = CartItem.find(params[:id])
    item.quantity > 1 ? item.decrement!(:quantity) : item.destroy
    redirect_to cart_path
  end
end
