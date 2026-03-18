class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :variant

  validates :quantity, numericality: { greater_than: 0 }

  # def price_cents
  #   (price * 100).to_i
  # end
end
