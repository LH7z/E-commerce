class AddCepAndCpfAndTelefoneToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :cep, :string
    add_column :users, :cpf, :string
    add_column :users, :telefone, :string
  end
end
