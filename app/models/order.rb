class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true, inclusion: { in: %w[pending paid canceled] }

  def total_cents
      order_items.sum { |item| item.price * item.quantity }
  end

  def total
    total_cents / 100.0
  end
end
