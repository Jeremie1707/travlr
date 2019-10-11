class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  pictures = ['https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193337/henningsvaer_jy1zjs.jpg',
              'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193325/lofoten-aquarium_xulkoy.jpg',
              'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193346/Lofoten_-_Henningsvaer_xqi7ng.jpg',
              'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193364/reine_udowot.jpg',
              'https://res.cloudinary.com/dvluu9bpc/image/upload/v1570193374/svolvoergeita_pur2sy.jpg'
              ]

  address = ['8312 Henningsvær',
            '8310 Kabelvåg',
            '8392 Sørvågen',
            '8390 Reine',
            '8300 Svolvær'
            ]

  def seedItems
    @trip
  end

  private

  def find_trip
    @trip = Trip.last
  end
end
