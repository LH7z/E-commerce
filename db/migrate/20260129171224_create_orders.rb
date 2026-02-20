class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.string :stripe_session_id
      t.string :status
      t.integer :total_cents

      t.timestamps
    end
  end
end
