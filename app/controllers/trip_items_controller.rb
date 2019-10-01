# class TripItemsController < ApplicationController
#   before_action find_trip_item, only: [:show, :destroy]

#   def new
#     @trip_item = TripItem.new
#   end

#   def create
#     @trip_item = TripItem.new
#     @trip_item.user = current_user

#     if @trip_item.save!
#       render next
#     else
#       render :new
#     end
#   end

#   def index
#     @trip_items = TripItem.all
#   end

#   def show
#   end

#   def destroy
#   end

#   private

#   def strong_params
#     params.require(:trip_item).permit(:name, :address, :start_date, :end_date, :description, :price, :photo, :link)
#   end

#   def find_trip_item
#     @trip_item = TripItem.find(param[:id])
#   end
# end
