class LikesController < ApplicationController
  before_action :find_item

  def create
    @trip_item.likes.create(user_id: current_user.id)
    redirect_back fallback_location: root_path
  end

  private

  def find_item
    @trip_item = TripItem.find(params[:trip_item_id])
  end
end
