class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update]
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(strong_params)
    @trip.user = current_user
    @trip.save
  end

  def show
  end

  def index
    @trips = Trips.all
  end

  def edit
  end

  def update

    strong_params
    raise
  end

  def destroy
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def strong_params
    params.require(:trip).permit(:description, :start_date, :end_date)
  end
end
