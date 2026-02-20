class AddNumberToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :number, :string
    add_column :users, :adress, :string
  end
end
