class AddColToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :price, :integer, null: false, default: 0
    add_column :order_items, :quantity, :integer, null: false, default: 1
  end
end
