class InvitesController < ApplicationController
before_action :find_trip, only: [:create]

  def new
    @invite = Invite.new
  end

  def create
    @new_user = User.create
    @invite.recipient_id = @new_user.id
     @invite = Invite.new(invite_params) # Make a new Invite
     @invite.trip = @trip
     @invite.sender_id = current_user.id # set the sender to the current user
     if @invite.save
        InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
        redirect_to trip_path(@trip)

         #send the invite data to our mailer to deliver the email
         #
     else
      raise
       puts @invite.errors.full_messages
       puts "something goes wrong"
       redirect_to trip_path(@trip)
        # oh no, creating an new invitation failed
     end
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def invite_params
    params.require(:invite).permit(:email, :token, :sender_id, :trip_id, :recipient_id)
  end

end
