# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create name: "Admin", email: "admin@gmail.com",
  password: "123123", password_confirmation: "123123", role: 1
Faker::Date.backward(14)
12.times do |n|
  Place.create name: Faker::Name.name
  Discount.create title: Faker::Name.name, status: 1,
    start_date: Faker::Date.backward(16), end_date: Faker::Date.backward(16),
    percent: Faker::Number.number(2)
end
