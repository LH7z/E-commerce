class CheckoutController < ApplicationController
  before_action :authenticate_user!
def create
  if params[:order_id]
    order = current_user.orders.find(params[:order_id])
  else
    cart = current_user.cart

    order = current_user.orders.create!(
      status: "pending",
      total_cents: cart.total_cents
    )

    cart.cart_items.each do |item|
      order.order_items.create!(
        product: item.product,
        quantity: item.quantity,
        variant: item.variant,
        price: item.product.discounted_price_cents,
        discount: item.product.discount
      )
    end
  end

  line_items = order.order_items.map do |item|
    {
      price_data: {
        currency: "brl",
        unit_amount: item.product.discounted_price_cents,
        product_data: { name: item.product.name }
      },
      quantity: item.quantity
    }
  end
  if line_items.empty?
    redirect_to orders_path, alert: "Esse pedido não tem itens"
    return
  end

  session = Stripe::Checkout::Session.create(
    line_items: line_items,
    mode: "payment",
    metadata: { order_id: order.id },
    success_url: "https://e-commerce-563f.onrender.com?order_id=#{order.id}",
    cancel_url: "https://e-commerce-563f.onrender.com/checkout/cancel?order_id=#{order.id}",
  )

  redirect_to session.url, allow_other_host: true
end


  def success

  end

  def cancel
    @order = Order.find(params[:order_id])
  end
end
