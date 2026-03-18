class Variant < ApplicationRecord
  belongs_to :product
  has_many :order_items

  validates :size, presence: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def used?
    order_items.exists?
  end

end
