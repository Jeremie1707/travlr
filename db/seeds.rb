# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


puts "User count  = #{User.count}"
puts "Trip count = #{Trip.count}"
puts "Trip item count  = #{TripItem.count}"
puts "Category count = #{Category.count}"
puts '---------deleting all records---------------'
TripItem.destroy_all
Trip.destroy_all
User.destroy_all
Category.destroy_all


pictures = ['https://res.cloudinary.com/dswkxjcbj/image/upload/v1569412062/andre-benz-RAXQkgmyrcA-unsplash_jwbjde.jpg',
            'https://res.cloudinary.com/dswkxjcbj/image/upload/v1569412063/rooms-with-amazing-view-38__880_i4gabh.jpg',
            'https://res.cloudinary.com/dswkxjcbj/image/upload/v1569412063/Room_with_a_view_Sentosa_qa9ecy.jpg',
            'https://res.cloudinary.com/dswkxjcbj/image/upload/v1569412063/picture_of_a_hut_befc3f.jpg',
            'https://res.cloudinary.com/dswkxjcbj/image/upload/v1569412063/marine-fishingboats-ireland_phwk52.jpg',
]

address = [  'Nordlysveien 10, Oslo',
             'Myrerskogveien 80, Oslo',
             'Voksenkollveien 2, Oslo',
             'Nordre skansemyren 10, Bergen',
             'Via Panisperna, 236, 00184 Roma RM, Italy',
]

categories = [  'Lodging',
                'Transportation'
]


counter = 0
category_counter = 0
category = Category.create(name: 'Activity')

category = Category.create(name: 'Loging')

puts "------------seeding-----------"
user = User.create(email: 'test@test.as', password: 'test123', first_name: 'Tess', last_name: 'Est')

trip = Trip.create(description: 'fint hus', start_date: Date.today.to_s, end_date: (Date.tomorrow + rand(10..50)).to_s, user_id: user.id, location: 'Holmenkollen', name: 'Nikkers-safari')

2.times do
  Category.create(name: categories[category_counter])
  category_counter += 1
  puts category_counter + 1
end

5.times do
  attributes = {

    name: Faker::Address.state,
    address: address[counter],
    remote_photo_url: pictures[counter],
    price: rand(10..50),
    link: "www.travlr.group",
    start_date: Date.today.to_s,
    end_date: (Date.today + rand(10..50)).to_s,
    description: Faker::Restaurant.review,
    user_id: user.id,
    trip_id: trip.id,
    category_id: category.id
  }

  TripItem.create(attributes)
  counter += 1
  puts counter
end

puts "---------seeding done--------"
puts "Category count = #{Category.count}"
puts "User count = #{User.count}"
puts "Trip count = #{Trip.count}"
puts "Trip item count = #{TripItem.count}"
