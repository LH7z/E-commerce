require "faraday"
require "json"

class MercadoPagoCheckout
  API_URL = "https://api.mercadopago.com/checkout/preferences"

  def self.create(product)
    response = Faraday.post(API_URL) do |req|
      req.headers["Authorization"] =
        "Bearer #{Rails.application.credentials.dig(:mercado_pago, :access_token)}"
      req.headers["Content-Type"] = "application/json"

      req.body = {
        items: [
          {
            title: product.name,
            quantity: 1,
            unit_price: product.price.to_f,
            currency_id: "BRL"
          }
        ],
        back_urls: {
          success: "http://localhost:3000/success_mercado",
          failure: "http://localhost:3000/cancel_mercado",
          pending: "http://localhost:3000/cancel_mercado"
        },
        # auto_return: "approved"
      }.to_json
    end

    puts response.status
    puts response.body

    JSON.parse(response.body)
  end
end
