class TripItem < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  belongs_to :category
  has_many :comments
  has_many :action_log_items
  has_many :likes
end
