class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :trip_item
  validates :comment, presence: true
  validates :comment, length: { minimum: 1 }
end
