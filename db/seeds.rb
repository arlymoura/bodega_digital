require 'faker'

# Limpar dados existentes
# User.destroy_all
# Admin.destroy_all
# Category.destroy_all
# Product.destroy_all
# ProductVariant.destroy_all
# Stock.destroy_all
# StockItem.destroy_all



ActiveRecord::Base.transaction do
  # Criar Member
  admin = Member.find_or_create_by!(
    email: 'arlymoura@gmail.com'
  ) do |a|
    a.name = 'Arly Moura'
    a.password = '123456'
    a.document = Faker::IDNumber.brazilian_citizen_number
    a.document_type = 'CPF'
    a.role = 'admin'
  end

  admin_maneger = Member.find_or_create_by!(
    email: 'manager_time@time.com'
  ) do |a|
    a.name = Faker::Name.name
    a.password = '123456'
    a.document = Faker::IDNumber.brazilian_citizen_number
    a.document_type = 'CPF'
    a.role = 'manager'
  end

  # Criar Usuários
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password'
  )

  # Criar Categorias
  5.times do
    Category.create!(
      name: Faker::Commerce.department(max: 1),
      description: Faker::Lorem.paragraph
    )
  end

  # Criar estoque

  Stock.create!(
    name: 'Estoque Principal',
    description: 'Estoque principal da loja'
  )

  # create products
  20.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      kind: Product.kinds.keys.sample,
      status: :active,
      category: Category.all.sample
    )

    # create product variants
    product_variant = ProductVariant.create!(
      product: product,
      status: [:active, :disabled, :scheduled].sample,
      properties: { type: "Tamanho", value: ['P', 'M', 'G', 'GG'].sample }
    )

    # create stock items
    StockItem.create!(
      product_variant: product_variant,
      stock: Stock.first,
      quantity: Faker::Number.between(from: 1, to: 100),
      min_quantity: Faker::Number.between(from: 1, to: 20),
      price: Faker::Commerce.price(range: 100.0..400.0)
    )
  end
end


puts 'Seed data created successfully.'
