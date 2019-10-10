class TripsController < ApplicationController
  # include Wicked::Wizard
  # steps  :add_description, :add_start_date, :add_end_date

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
      # redirect_to trip_path(@trip)
      redirect_to trip_form_index_path
      @trip.users = @users unless @users.empty?
    else
      render :new, alert: @trip.errors.full_messages
    end
  end

  def show
    @comment = Comment.new
    @trip_item = TripItem.new
    # set markers for trip suggestions map
    @map_items_suggestions = @trip.trip_items.geocoded
    @markers_for_suggestions = create_markers(@map_items_suggestions)

    # set markers for Route map
    @map_trip_items_confirmed = TripItem.where("trip_id = ? and confirmed = ?", "#{@trip.id}", "true").geocoded
    @map_for_confirmed = create_markers(@map_trip_items_confirmed)

    @trip_items = @trip.trip_items
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def create_markers(trip_items)
    respond_to do |format|
      format.html do
        markers = trip_items.map do |trip_item|
          {
            lat: trip_item.latitude,
            lng: trip_item.longitude,
            infoWindow: render_to_string(partial: "info_window", locals: { trip_item: trip_item }),
            image_url: helpers.asset_url('lightbulb-regular.svg') # could probably implement different markers based on category(house for lodging etc.)
          }
        end
        markers
      end
      format.json
    end
  end

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
