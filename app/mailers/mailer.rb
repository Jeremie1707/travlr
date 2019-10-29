class Mailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def confirmation_instructions(user)
    @user = user # Instance variable => available in view
    mail(to: @user.email, subject: 'Confirm your eamil <address>  </address> for Travlr!')
    # This will render a view in `app/views/user_mailer`!
  end

  def email_changed(user)
    @user = user # Instance variable => available in view
    mail(to: @user.email, subject: 'Change your email for Travlr!')
    # This will render a view in `app/views/user_mailer`!
  end

  def password_change(user)
    @user = user # Instance variable => available in view
    mail(to: @user.email, subject: 'Change your password for Travlr!')
    # This will render a view in `app/views/user_mailer`!
  end

  def reset_password_instructions(user)
    @user = user # Instance variable => available in view
    mail(to: @user.email, subject: 'Reset your password for Travlr!')
    # This will render a view in `app/views/user_mailer`!
  end

  def unlock_instructions(user)
    @user = user # Instance variable => available in view
    mail(to: @user.email, subject: 'Unlock your Travlr account!')
    # This will render a view in `app/views/user_mailer`!
  end
end
