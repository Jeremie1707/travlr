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
      @users = User.where.not(id: current_user.id)
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
      @trip.users = set_users
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
