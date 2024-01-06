require 'faker'
1.upto(10) do |i|
  vendor = Vendor.create(name: Faker::Name.name)
  category = Category.create(title: Faker::Food.ethnic_category)
  1.upto(30) do |j|
    product = vendor.products.create(title:Faker::Food.allergen,description: Faker::Food.description, price: rand(1000) )
    product.product_categories.create!(category_id: category.id)

  end
end

1.upto(20) do |i|
end


users = [
  { email: 'vendor@tecaudex.com', password: 'password', role: 'vendor' },
  { email: 'customer@tecaudex.com', password: 'password', role: 'customer' },
]

users.each do |user|
  u = User.create(user)
  if user[:role] == "vendor"
    u.roles.destroy_all
    u.add_role :vendor
  else
    u.add_role :customer
  end
end
