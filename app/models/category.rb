class Category < ApplicationRecord
  has_many :trip_items, dependent: :destroy
end
