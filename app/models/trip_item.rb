class TripItem < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  belongs_to :trip
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :action_log_items, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :start_date, presence: true
end
