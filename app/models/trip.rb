class Trip < ApplicationRecord
  validates :description, :start_date, :end_date, presence: true
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :trip_items
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
