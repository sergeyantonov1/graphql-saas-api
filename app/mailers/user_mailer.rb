class UserMailer < ApplicationMailer

  def invitation_email(user)
    subject = ""

    mail to: user.email, subject: ""
  end
end
