# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Limpando banco (opcional em dev)
OrderItem.destroy_all
Order.destroy_all
Variant.destroy_all
Product.destroy_all
User.destroy_all

puts "🌱 Criando usuários..."

admin = User.create!(
  email: "admin@site.com",
  password: 123456,
  admin_code: 123456,
  role: :admin
)

user = User.create!(
  email: "user@email.com",
  password: "123456",
  cep: "12345-678",
  number: "123",
  cpf: "123.456.789-00",
  telefone: "(12) 34567-8901",
  role: :customer,
  adress: "Rua Exemplo, 123",
  complement: "Apto 456"
)

puts "👕 Criando produtos..."

products = [
  {
    name: "bone",
    price: 99.90,
    discount: 10,
    description: "Camiseta oversized estilo urbano"
  },
  {
    name: "calça jeans",
    price: 249.90,
    discount: 15,
    description: "Tênis confortável para o dia a dia"
  },
  {
    name: "vestido",
    price: 199.90,
    discount: 0,
    description: "Moletom pesado e confortável"
  }
]

products.each do |product_data|
  product = Product.create!(product_data)

  puts "📦 Criando variantes para #{product.name}..."

  sizes = ["P", "M", "G", "GG"]

  sizes.each do |size|
    Variant.create!(
      product: product,
      size: size,
      stock: rand(5..20)
    )
  end
  product.image.attach(io: File.open(Rails.root.join("app/assets/images/#{product.name}.png")), filename: "#{product.name}.png")
end
