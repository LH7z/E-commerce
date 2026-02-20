class CheckoutMercadoController < ApplicationController
def create
  product = Product.find(params[:product_id])

  preference = MercadoPagoCheckout.create(product)

  if preference["init_point"].present?
    redirect_to preference["init_point"], allow_other_host: true
  else
    render json: preference, status: :unprocessable_entity
  end
end
  def success
    render plain: "Pagamento aprovado com sucesso via Mercado Pago!"
  end

  def cancel
    render plain: "Pagamento cancelado via Mercado Pago."
  end
end
