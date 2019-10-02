class TripsController < ApplicationController
  # include Wicked::Wizard
  # steps  :add_description, :add_start_date, :add_end_date, :add_

  before_action :set_trip, only: [:show, :update]
  before_action :set_users, only: [:create]
  def new
    @trip = Trip.new
    @users = User.all
  end

  def create
    @trip = Trip.new(strong_params)
    @trip.user = current_user
    if @trip.save
      redirect_to trip_path(@trip)
      @trip.users = @users
    else
      render :new, alert: @trip.errors.full_messages
    end
  end

  def show
  end

  def index
    @trips = Trips.all
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def set_users
    @users = []
    ids = params[:trip][:users]
    ids.each do |user|
      @users << User.find(user.to_i)
    end
  end

  def strong_params
    params.require(:trip).permit(:description, :start_date, :end_date)
  end
end
