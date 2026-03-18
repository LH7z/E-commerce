class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.raw_post
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    event = Stripe::Webhook.construct_event(
      payload,
      sig_header,
      endpoint_secret
    )

    case event.type
    when "checkout.session.completed"
      session = event.data.object

      order = Order.find(session.metadata.order_id)

      order.update(status: "paid")

      # limpa o carrinho após pagamento
      order.user.cart.cart_items.destroy_all
    end

    render json: { received: true }
  rescue => e
    Rails.logger.error e.message
    render json: { error: e.message }, status: 400
  end
end
