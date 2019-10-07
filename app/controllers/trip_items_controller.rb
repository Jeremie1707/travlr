class TripItemsController < ApplicationController
  before_action :find_trip_item, only: [:show, :destroy, :update, :like]
  before_action :find_trip, only: [:create, :show]

  def new
    @trip_item = TripItem.new
  end

  def create
     @trip_item = TripItem.new(strong_params)
     @trip_item.user = current_user
     @trip_item.trip = @trip
     if @trip_item.save!
      redirect_to trip_path(@trip)
     else
       render :new
     end
      Like.create!(trip_item_id: @trip_item.id, user_id: @trip_item.user_id)
  end

  def index
    @trip_items = TripItem.geocoded

    @markers = @trip_items.map do |trip_item|
      {
        lat: trip_item.latitude,
        lng: trip_item.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { trip_item: trip_item }),
        image_url: helpers.asset_url('logotravlr.svg') # could probably implement different markers based on category(house for lodging etc.)
      }
    end
  end

  def like
    Like.create!(trip_item_id: @trip_item.id, user_id: current_user.id)
  end


  def show
    @comment = Comment.new
  end

  def update
    find_trip
    @trip_item.update(strong_params)
    redirect_to trip_path(@trip)
  end

  def destroy
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def strong_params
    params.require(:trip_item).permit(:name, :address, :start_date, :end_date, :description, :price, :photo, :link, :category_id, :confirmed)
  end

  def find_trip_item
    @trip_item = TripItem.find(params[:id]) # changed it to :id instead of trip_item_id for the edit to work. Might cause issues - Petter
  end
end
