class UserMailer < ApplicationMailer
  default from: 'no-reply@twlms.com'

  def verification_email(user)
    @user = user
    @url = "http://localhost:3000/verify/#{User.new_token}"
    mail(to: @user.email, subject: 'Verify your email address for twlms.com')
  end
end
