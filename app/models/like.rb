class Like < ApplicationRecord
  belongs_to :user
  belongs_to :trip_item
end
