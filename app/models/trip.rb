class Trip < ApplicationRecord
  # validates :start_date, :name, presence: true
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants, dependent: :destroy
  has_many :trip_items, dependent: :destroy
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  validates :description, length: { maximum: 40 }
  validates :location, presence: true, length: { minimum: 1 }

  def seedItems
    attributes = [
      {name: "3 Days of Everything",
       address: 'Torget 21, 8300 Svolvær',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570786014/3_days_ftxjhq.jpg',
       price: '1900',
       link: "www.travlr.group", # make array of different links
       start_date: '2019.10.19',
       end_date: '2019.10.22',
       description: 'testsetset',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'activity')
      },
      {name: "Diving",
       address: 'Skarsjyveien 67, 8373 Ballstad',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570786025/diving_gqz01j.jpg',
       price: '8000',
       link: "", # make array of different links
       start_date: '2019.10.23',
       end_date: '2019.10.23',
       description: 'Scuba diving guys? You don’t need any prior training, this looks awesome, the water is really clear this time of year.',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'activity')
      },
      {name: "Whalesafari",
       address: 'Hamnegata 1C, 8480 Andenes',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570786072/whale_eyifot.jpg',
       price: '',
       link: "http://www.whalesafari.no/", # make array of different links
       start_date: '2019.10.24',
       end_date: '2019.10.24',
       description: 'It is a bit of a drive, four hour drive each way. But they guarantee to see whales! If the weather isn’t to bad to even go out! I’m in! You?',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'activity')
      },
      {name: "Kayak",
       address: 'Eggumsveien 867, 8360 Bøstad',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570786038/kayak_xlelvz.jpg',
       price: '800',
       link: "https://lofoten.info/en/summer/Kayak/?Article=1011", # make array of different links
       start_date: '2019.10.26',
       end_date: '2019.10.26',
       description: 'A scenic exploration of the fjords and islands” sounds pretty dang spiffy to me, I will do this, how do you feel?',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'activity')
      },
      {name: "Svolværgeita",
       address: 'Svolvær',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570546504/z2liny8g4nywwybsifv7.jpg',
       price: '2000',
       link: "https://www.alpineguides.no/services/climb-svolvaergeita/", # make array of different links
       start_date: '2019.10.27',
       end_date: '2019.10.27',
       description: 'From what I read you basically have to do this when you are in Lofoten.  But it is a bit expensive?',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'activity')
      },
      {name: "Campervan",
       address: 'Svolvært',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570787949/camping_wtbsui.jpg',
       price: '1500',
       link: "", # make array of different links
       start_date: '2019.10.19',
       end_date: '2019.10.27',
       description: 'A friend of my father has this old car we can rent for next to nothing for the entire trip! Campervan, man:)',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'transport')
      },
      {name: "Ballstad - House",
       address: '8373 Ballstad ',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570786248/house_ballstad-1_vopunl.png',
       price: '2500',
       link: 'https://www.airbnb.no/rooms/17717254?location=Ballstad%2C%20Norge&source_impression_id=p3_1570782800_7AYEVr5EBW70T0Un', # make array of different links
       start_date: '2019.10.23',
       end_date: '2019.10.24',
       description: 'Just read the description of this place on AIRBNB. It is small, but it seems amazing.',
       user: self.participants.sample.user,
       trip_id: self.id,
       category: Category.find_by(name: 'housing')
      }
    ]

    attributes.each do |attribute|
      TripItem.create!(attribute)
    end

    # TripItem.create!(attributes[0])
    # puts attributes[0]

    # participant1 = Participant.create(trip_id: id, user_id: User.find())
    # participant2 = Participant.create(trip_id: id, user_id: User.find())
    # participant3 = Participant.create(trip_id: id, user_id: User.find())
    # participant4 = Participant.create(trip_id: id, user_id: User.find())

    # start_dates = []
    # end_dates = []
    # counter_start = 0
    # counter_end = 1
    # 5.times do
    #   start_dates << (Date.today + counter_start).to_s
    #   end_dates << (Date.today + counter_end).to_s
    #   counter_start += 1
    #   counter_end += 2
    # end

    # counter = 0

    # 5.times do
    #   attributes = {

    #     name: name[counter],
    #     address: address[counter],
    #     remote_photo_url: pictures[counter],
    #     price: rand(100..1000),
    #     link: "www.travlr.group", # make array of different links
    #     start_date: start_dates[counter],
    #     end_date: end_dates[counter],
    #     description: Faker::Restaurant.review, # make better decr
    #     user: self.participants.sample.user,
    #     trip_id: self.id,
    #     category: categories[counter]
    #   }

    #   # TripItem.create(attributes)
    #   trip = TripItem.create!(attributes)
    #   counter += 1
    # end
  end
end
