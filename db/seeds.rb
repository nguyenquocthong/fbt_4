# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create name: "Admin", email: "admin@gmail.com",
  password: "123123", password_confirmation: "123123", role: 1

place = Place.create name: Faker::Name.name

24.times do |n|
  user = User.create name: Faker::Name.name, email: "test#{n}@gmail.com",
    password: "123123", password_confirmation: "123123"
  place = Place.create name: Faker::Name.name

  tour = Tour.create place_id: 1,
    name: Faker::Name.name,
    time_tour: Faker::Time.between(DateTime.now - 1, DateTime.now),
    start_day: Faker::Date.between(2.days.ago, Date.today),
    start_place: Faker::Address.city,
    price: Faker::Number.number(6),
    description: Faker::Hipster.paragraph, is_active: true,
    image: "https://s14.postimg.org/f90o7orwh/du_lich_thai_lan.jpg"
end

tour = Tour.first
user1 = User.first
user2 = User.last
5.times do
  review = Review.create tour_id: tour.id, user_id: user1.id,
    title: Faker::Name.name, content: Faker::Hipster.paragraph
end
5.times do
  review = Review.create tour_id: tour.id, user_id: user2.id,
    title: Faker::Name.name, content: Faker::Hipster.paragraph
end
review = Review.first
review2 = Review.last
10.times do
  Comment.create user_id: user2.id, review_id: review.id, content: Faker::Name.name
end
10.times do
  Comment.create user_id: user2.id, review_id: review2.id, content: Faker::Name.name
end
