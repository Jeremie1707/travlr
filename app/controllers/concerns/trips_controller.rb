class TripsController < ApplicationController
  before_action :set_trip, onyl: [:show]
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(strong_params)
    @trip.user = current_user

    if trip.save!
      redirect to
    else
      render :new
    end
  end

  def show
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def strong_params
    params.require(:trip).permit(:description, :start_date, :end_date)
  end
end
