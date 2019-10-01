class Trip < ApplicationRecord
  belongs_to :user
  has_many :users, through: :participants
  has_many :trip_items
end
