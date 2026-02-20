class AddComplementToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :complement, :string
  end
end
