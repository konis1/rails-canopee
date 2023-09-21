class ApplicationMailer < ActionMailer::Base
  # default from: "bonnefeuilleparis@gmail.com"
  # layout "welcome_email"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur notre site! Merci pour votre commande')
  end

end
