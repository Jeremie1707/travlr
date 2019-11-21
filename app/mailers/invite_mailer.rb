class InviteMailer < ApplicationMailer
  def new_user_invite(invite, edit_password_path)
    @invite = invite # Instance variable => available in view
    # user = User.find_by(id: @invite.recipient)
    # user.set_initial_password_reset!
    @new_user_registration_url = edit_password_path
    mail(to: @invite.email, subject: 'Welcome to Travlr!')
    # This will render a view in `app/views/user_mailer`!
    @trip = Trip.find_by(id: @invite.trip_id)
    @sender = User.find_by(id: @invite.sender)


  end

  def existing_user_invite(invite, new_user_session_path)
    @invite = invite # Instance variable => available in view
    @new_user_session_url = new_user_session_url
    mail(to: @invite.email, subject: 'Welcome to Travlr!')
    # This will render a view in `app/views/user_mailer`!
    @trip = Trip.find_by(id: @invite.trip_id)
    @sender = User.find_by(id: @invite.sender)

  end
end
