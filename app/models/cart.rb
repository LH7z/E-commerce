class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def total_cents
    cart_items.sum(&:subtotal_cents)
  end
end
