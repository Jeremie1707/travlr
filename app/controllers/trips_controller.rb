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
      @trip.users = @users unless @users.empty?
    else
      render :new, alert: @trip.errors.full_messages
    end
  end

  def show
    @trip_item = TripItem.new
    @trips = Trip.geocoded

    @markers = @trips.map do |trip|
      {
        lat: trip.latitude,
        lng: trip.longitude,
        infoWindow: render_to_string(partial: "info_windowtrip", locals: { trip: trip }),
        image_url: helpers.asset_url('logotravlr.svg') # did not include markers as this is primarily for centering the map.
      }
    end
  end

  def index
    # @trips = Trip.all
    #@trips = Trip.geocoded

    #@markers = @trips.map do |trip|
      #{
       # lat: trip.latitude,
        #lng: trip.longitude # did not include markers as this is primarily for centering the map.
      #}
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
    ids.each { |user| @users << User.find(user.to_i) } unless ids.nil?
  end

  def strong_params
    params.require(:trip).permit(:description, :start_date, :end_date, :location, :name)
  end
end
