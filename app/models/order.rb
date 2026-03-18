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

  after_update :update_stock, if: :saved_change_to_status?

  private

  def update_stock
    Rails.logger.info "STATUS CHANGE: #{saved_change_to_status}"

    old_status, new_status = saved_change_to_status

    if old_status != "paid" && new_status == "paid"
      decrease_stock
    elsif old_status == "paid" && new_status == "canceled"
      restore_stock
    end
  end

  def decrease_stock
    order_items.each do |item|
      variant = item.variant
      next unless variant

      new_stock = variant.stock - item.quantity
      new_stock = 0 if new_stock < 0

      variant.update!(stock: new_stock)
    end
  end

  def restore_stock
    order_items.each do |item|
      variant = item.variant
      next unless variant

      variant.update!(stock: variant.stock + item.quantity)
    end
  end
end
