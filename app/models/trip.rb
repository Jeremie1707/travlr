class Trip < ApplicationRecord
  validates :description, :start_date, :end_date, presence: true
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :trip_items
end
