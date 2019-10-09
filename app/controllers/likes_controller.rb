class LikesController < ApplicationController
  before_action :find_item
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @trip_item.likes.create(user_id: current_user.id)
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to trip_trip_item_path(@trip_item)
  end

  private

  def find_item
    @trip_item = TripItem.find(params[:trip_item_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, trip_item_id:
    params[:trip_item_id]).exists?
  end

  def find_like
    @like = @trip_item.likes.find(params[:id])
  end
end
