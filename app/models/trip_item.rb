class TripItem < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  belongs_to :trip
  belongs_to :category
  has_many :comments
  has_many :action_log_items
  has_many :likes
  mount_uploader :photo, PhotoUploader
end
