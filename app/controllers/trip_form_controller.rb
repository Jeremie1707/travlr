class TripFormController < ApplicationController
  include Wicked::Wizard

  steps :description, :date, :friends

  def show
    case step
    when :description
      @trip = Trip.last
    when :date
      @trip = Trip.last
    when :friends
      @trip = Trip.last
      @users = set_users
    end
    render_wizard
  end

  def update
    @trip = Trip.last
    case step
    when :description
      @trip.update_attributes(strong_params)
    when :date
      @trip.update_attributes(strong_params)
    when :friends
      @users = @trip.users
      raise
      # @trip.users = @users unless @users.empty?
    end
    render_wizard(@trip)
    @trip.save
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
    @users = []
    @users << User.find(current_user.id)
    params[:trip][:users].each { |user| @users << User.find(user) } unless params[:trip].nil?
    @users

  end

  def finish_wizard_path
    @trip = Trip.last
    trip_path(@trip)
  end

end
