class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :variants, dependent: :destroy

  has_many :cart_items, dependent: :destroy

  has_one_attached :image

  accepts_nested_attributes_for :variants, allow_destroy: true

  def price_cents
    (price * 100).to_i
  end

  def discounted_price_cents
    if discount > 0
      (price_cents - (price_cents * discount / 100)).to_i
    else
      price_cents
    end
  end
end
