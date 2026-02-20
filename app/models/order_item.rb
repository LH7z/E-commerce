class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }

  # def price_cents
  #   (price * 100).to_i
  # end
end
