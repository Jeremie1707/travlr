class ActionLogItem < ApplicationRecord
  belongs_to :trip_item
  belongs_to :user
end
