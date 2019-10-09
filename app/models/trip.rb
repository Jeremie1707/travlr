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
end
