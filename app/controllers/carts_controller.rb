class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart = current_user.cart
  end

  def destroy
    current_user.cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Carrinho esvaziado com sucesso."
  end
end
