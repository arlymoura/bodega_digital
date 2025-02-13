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
  # Criar Account
  account = Account.create!(name: 'Grupo Teste')

  # Criar Company
  company = Company.find_or_create_by!(
    name: 'Empresa Teste',
    account_id: account.id
  )

  company2 = Company.find_or_create_by!(
    name: 'Empresa Teste 2',
    account_id: account.id
  )

  # Criar Member
  admin = User.find_or_create_by!(
    email: 'arlymoura@gmail.com'
  ) do |a|
    a.name = 'Arly Moura'
    a.password = '123456'
    a.document_number = Faker::IDNumber.brazilian_citizen_number
    a.document_type = 'CPF'
    a.role = 'admin'
  end


  # Criar relação entre usuário e empresa
  Membership.find_or_create_by!(
    user: admin,
    company_id: company.id,
    role: :owner
  )

  admin_maneger = User.find_or_create_by!(
    email: 'manager_time@time.com'
  ) do |a|
    a.name = Faker::Name.name
    a.password = '123456'
    a.document_number = Faker::IDNumber.brazilian_citizen_number
    a.document_type = 'CPF'
    a.role = 'manager'
  end

  Membership.find_or_create_by!(
    user: admin_maneger,
    company_id: company2.id,
    role: :member
  )

  # Criar Categorias
  5.times do
    Category.create!(
      name: Faker::Commerce.department(max: 1),
      description: Faker::Lorem.paragraph,
      account_id: account.id,
      company_id: company.id
    )
  end

  # Criar estoque

  Stock.create!(
    name: 'Estoque Principal',
    description: 'Estoque principal da loja',
    account_id: account.id,
    company_id: company.id
  )

  # create products
  20.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      kind: Product.kinds.keys.sample,
      status: :active,
      category: Category.all.sample,
      account_id: account.id,
      company_id: company.id
    )

    # create product variants
    variant = Variant.create!(
      product: product,
      status: [:active, :disabled, :scheduled].sample,
      properties: { type: "Tamanho", value: ['P', 'M', 'G', 'GG'].sample },
      account_id: account.id,
      company_id: company.id
    )

    # create stock items
    StockItem.create!(
      variant: variant,
      stock: Stock.first,
      quantity: Faker::Number.between(from: 1, to: 100),
      min_quantity: Faker::Number.between(from: 1, to: 20),
      price: Faker::Commerce.price(range: 100.0..400.0),
      account_id: account.id,
      company_id: company.id
    )
  end
end


puts 'Seed data created successfully.'
