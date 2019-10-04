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
Category.destroy_all
Trip.destroy_all
User.destroy_all
Category.destroy_all


pictures = ['https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193337/henningsvaer_jy1zjs.jpg',
            'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193325/lofoten-aquarium_xulkoy.jpg',
            'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193346/Lofoten_-_Henningsvaer_xqi7ng.jpg',
            'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193364/reine_udowot.jpg',
            'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193374/svolvoergeita_pur2sy.jpg',
]

address = [  'Banhammeren 53, 8312 Henningsvær',
             'Storvåganveien 28, 8310 Kabelvåg',
             'Å vegen 5, 8392 Sørvågen',
             'Reine i Lofoten, 8390 Reine',
             'Svolværgeita, 8300 Svolvær'
]


activity = [  "Going fishing",
             "Lofoten aquarium",
             "Fishing museum",
             "Rorbue",
             "Mountain trip",
]

categories = [  'Lodging',
                'Transportation'
]
counter = 0
category_counter = 0
category = Category.create(name: 'Activity')

category = Category.create(name: 'Loging')

category_counter = 0
category = Category.create(name: 'Activity')
puts "------------seeding-----------"
user = User.create(email: 'test@test.as', password: 'test123', first_name: 'Tess', last_name: 'Est')

trip = Trip.create(description: 'fint hus', start_date: Date.today.to_s, end_date: (Date.tomorrow + rand(10..50)).to_s, user_id: user.id, location: 'Lofoten', name: 'Lofoten trip')

2.times do
  Category.create(name: categories[category_counter])
  category_counter += 1
end

5.times do
  attributes = {

    name: activity[counter],
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
puts "Category count = #{Category.count}"
