class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :variant

  def subtotal_cents
    if product.discount > 0
      product.discounted_price_cents * quantity
    else
      product.price_cents * quantity
    end
  end

  def subtotal
    subtotal_cents / 100.0
  end
end
