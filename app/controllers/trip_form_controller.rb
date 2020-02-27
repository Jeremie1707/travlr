class TripFormController < ApplicationController
  include Wicked::Wizard
  before_action :set_trip, :limit_user_access_to_participant, only: [:show, :update]
  steps :description, :date, :friends


  def show
    if limit_user_access_to_participant
      case step
      when :description
      when :date
      when :friends
      @invite = Invite.new
      @users = set_users
      end
      render_wizard
    else
      redirect_to trips_path
    end
  end

  def update
    if limit_user_access_to_participant
      case step
      when :description
        @trip.update_attributes(strong_params)
      when :date
        @trip.update_attributes(strong_params)
      when :friends
        @trip.users = choose_users

        # @trip.users = @users unless @users.empty?
      end
      render_wizard(@trip)
      @trip.save
    else
      redirect_to trips_path
    end
  end

  private

  def strong_params
    params.require(:trip).permit(:description, :start_date, :end_date, :location, :name)
  end

  def set_users
    @trips_filter = []
    # select all the trip where the current user is a participant
    @participations_filter = current_user.participants
    # iterate on this list and return all the users for this trip selection
    @participations_filter.each do |element|
      @trips_filter << Trip.find_by(id: element[:trip_id])
    end
    @participants_filter = []
    @trips_filter.each do |trip|
      @participants_filter << trip.participants
    end
    @users_filter = []
    @participants_filter.sum.each do |participant|
      if User.find_by(id: participant[:user_id]) != current_user
      @users_filter << User.find_by(id: participant[:user_id])
      end
    end
    @users_filter_uniq = @users_filter.uniq


  end

  def choose_users
    @select_users = []
    @select_users << User.find(current_user.id)
    # params[:trip][:users].each { |user| @users << User.find(user) } unless params[:trip].nil?
    # @users
    # @users = []
    ids = params[:trip][:users]
    ids.each { |user| @select_users << User.find(user.to_i) } unless ids.nil?
    @select_users

  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def limit_user_access_to_participant
    set_trip
    @participants_list = @trip.participants
    @participants_list.each do |element|
      @check = element[:user_id] == current_user.id
      break if  @check == true
    end
    return @check
  end

  def finish_wizard_path
    @trip = Trip.find(params[:trip_id])
    trip_path(@trip)
  end

end
