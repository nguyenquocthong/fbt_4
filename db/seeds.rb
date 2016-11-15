# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Admin", email: "admin@gmail.com",
  password: "123123", password_confirmation: "123123", role: 1)

place = Place.create name: Faker::Name.name

24.times do
  tour = Tour.create place_id: 1,
    name: Faker::Name.name,
    time_tour: Faker::Time.between(DateTime.now - 1, DateTime.now),
    start_day: Faker::Date.between(2.days.ago, Date.today),
    start_place: Faker::Address.city,
    price: Faker::Number.number(6),
    description: Faker::Hipster.paragraph, is_active: true,
    image: "https://s14.postimg.org/f90o7orwh/du_lich_thai_lan.jpg"
end
