class AddVariantToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_items, :variant, null: false, foreign_key: true
  end
end
