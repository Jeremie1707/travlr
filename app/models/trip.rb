class Trip < ApplicationRecord
  # validates :start_date, :name, presence: true
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants, dependent: :destroy
  has_many :trip_items, dependent: :destroy
  has_many :invites
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  validates :description, length: { maximum: 40 }
  validates :location, presence: true, length: { minimum: 1 }

  def seedItems
    attributes = [
      {name: "Lofoten Vikging style",
       address: 'Torget 21, 8300 Svolvær',
       remote_photo_url: 'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570786014/3_days_ftxjhq.jpg',
       price: '1900',
       link: "www.travlr.group", # make array of different links
       start_date: '2019.10.19',
       end_date: '2019.10.22',
       description: '3 days of viking living in Lofoten, we wil be living in a small house on the beach living as the old vikings did 1000 years ago',
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

    tripitems = []
    attributes.each do |attribute|
      tripitems << TripItem.create!(attribute)
    end


    # 12.times do
    #   Like.create(user: self.participants.sample.user, trip_item: self.trip_items.sample)
    # end

    3.times do
      Like.create(user: self.participants.sample.user, trip_item: tripitems[2])
    end

    3.times do
      Like.create(user: self.participants.sample.user, trip_item: tripitems[0])
    end

    3.times do
      Like.create(user: self.participants.sample.user, trip_item: tripitems[3])
    end

    3.times do
      Like.create(user: self.participants.sample.user, trip_item: tripitems[5])
    end

    2.times do
      Like.create(user: self.participants.sample.user, trip_item: tripitems[6])
    end
    users = self.participants

    Comment.create(comment: 'I would love to wake up to that view, but it might be over budget? ', user: self.participants.last.user, trip_item: tripitems[6])
    Comment.create(comment: 'Yeah.. lets consider this when we meet on friday', user: self.participants.first.user, trip_item: tripitems[6])
    Comment.create(comment: 'I really like kayaking, and its not too expensive. Lets try this', user: self.participants.sample.user, trip_item: tripitems[3])

    Comment.create(comment: 'This looks like a cool thing', user: users.first.user, trip_item: tripitems[0])
    Comment.create(comment: 'Yeah, maby we can squeze it in between the diving and the whale safari', user: users.last.user, trip_item: tripitems[0])
    Comment.create(comment: 'sounds like a plan, lets add it', user: users[1].user, trip_item: tripitems[0])
  end
end

























