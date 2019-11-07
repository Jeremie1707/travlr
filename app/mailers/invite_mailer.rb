class InviteMailer < ApplicationMailer
  def new_user_invite(invite, new_user_registration_path)
    @invite = invite # Instance variable => available in view
    @new_user_registration_path = new_user_registration_path
    mail(to: @invite.email, subject: 'Welcome to Travlr!')
    # This will render a view in `app/views/user_mailer`!
  end
end
