class TripItemsController < ApplicationController
  before_action :find_trip_item, only: [:show, :destroy]

  def new
    @trip_item = TripItem.new
  end

  def create
    # @trip_item = TripItem.new
    # @trip_item.user = current_user
    # if @trip_item.save!
    #   render next
    # else
    #   render :new
    # end
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

  def show
  end

  def destroy
  end

  private

  def strong_params
    params.require(:trip_item).permit(:name, :address, :start_date, :end_date, :description, :price, :photo, :link, :category)
  end

  def find_trip_item
    @trip_item = TripItem.find(params[:id])
  end
end
