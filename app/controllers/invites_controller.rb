class InvitesController < ApplicationController
before_action :find_trip, only: [:create]

  def new
    @invite = Invite.new
  end

  def create
    if User.find_by(email: invite_params[:email])
      @user_invitee = User.find_by(email: invite_params[:email])
      create_invite
      if @invite.save
        InviteMailer.existing_user_invite(@invite, new_user_session_path(:invite_token => @invite.token)).deliver
        redirect_to edit_trip_trip_form(@trip)
          # send the invite data to our mailer to deliver the email
      else
        puts @invite.errors.full_messages
        puts "something goes wrong"
        redirect_to trip_path(@trip)
        # oh no, creating an new invitation failed
      end
    else
      @user_invitee = User.new(email: invite_params[:email]) do |u|
        u.password = SecureRandom.hex
      end
      @user_invitee.skip_confirmation!
      @user_invitee.save
      @trip.participants_ids << @user_invitee.id
      create_invite

      if @invite.save!
        invite_email(@user_invitee, @trip, @invite)
        # redirect_to trip_trip_form(@trip)
      else
        puts @invite.errors.full_messages
        puts "something goes wrong"
        redirect_to trip_path(@trip)
        # oh no, creating an new invitation failed
      end
    end
  end

  private

  def invite_email(invitee, trip, invite)
    InviteMailer.new_user_invite(invitee, trip, invite).deliver
  end

  def create_invite
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.recipient_id = @user_invitee.id
    @invite.trip = @trip
    @invite.sender_id = current_user.id # set the sender to the current user
  end

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def invite_params
    params.require(:invite).permit(:email, :token, :sender_id, :trip_id, :recipient_id)
  end
end
