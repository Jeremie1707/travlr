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

address = [  '8312 Henningsvær',
             '8310 Kabelvåg',
             '8392 Sørvågen',
             '8390 Reine',
             '8300 Svolvær'
]


activity = [  "Going fishing",
             "Lofoten aquarium",
             "Fishing museum",
             "Rorbue",
             "Mountain trip",
]

categories = [
{ "name" => "activity", "color" => "#1FB09A" },
{ "name" => "housing", "color" => "#ED8E34" },
{ "name" => "transport", "color" => "red" }
]


counter = 0

# category = Category.create(name: 'activity')
# category = Category.create(name: 'housing')
# category = Category.create(name: 'transport')

category_counter = 0
puts "------------seeding-----------"
user = User.create(email: 'test@test.as', password: 'test123', first_name: 'Petter', last_name: 'Gulliksen', remote_photo_url: "https://res.cloudinary.com/wagonapp/image/upload/v1570273638/gi5wgyp0ufiucnvnvsam.png" )

user2 = User.create(email: 'testjer@test.as', password: 'test123', first_name: 'Jeremie', last_name: 'Poiraudau', remote_photo_url: 'https://res.cloudinary.com/wagonapp/image/upload/v1570273822/o6xd2s1wdnzmutfx4ele.png')

user3 = User.create(email: 'testand@test.as', password: 'test123', first_name: 'Andre', last_name: 'Lauritzen', remote_photo_url: 'https://res.cloudinary.com/wagonapp/image/upload/v1570273827/wrtrbcyjxc85qgznob46.png')

user4 = User.create(email: 'testmag@test.as', password: 'test123', first_name: 'Magnus', last_name: 'Berntsen', remote_photo_url: 'https://res.cloudinary.com/wagonapp/image/upload/v1570273832/wpiskpjvemufpip1qeac.png')

trip = Trip.create(description: 'fint hus', start_date: Date.today.to_s, end_date: (Date.tomorrow + rand(10..50)).to_s, user_id: user.id, location: 'Lofoten', name: 'Lofoten trip')

participant1 = Participant.create(trip_id: trip.id, user_id: user.id)
participant2 = Participant.create(trip_id: trip.id, user_id: user2.id)
participant3 = Participant.create(trip_id: trip.id, user_id: user3.id)
participant4 = Participant.create(trip_id: trip.id, user_id: user4.id)


categories.each do |category|
Category.create(name: category["name"], color: category["color"])
category_counter += 1
end

# category = Category.create(name: activity, color: "#1FB09A")


5.times do

  attributes = {

    name: activity[counter],
    address: address[counter],
    remote_photo_url: pictures[counter],
    price: rand(10..50),
    link: "www.travlr.group",
    start_date: Date.today.to_s,
    end_date: (Date.today + rand(2..3)).to_s,
    description: Faker::Restaurant.review,
    user_id: user.id,
    trip_id: trip.id,
    category_id: rand(1..3).to_s
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
