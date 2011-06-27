class FlockMailer < ActionMailer::Base
  default :from => "andy@r2-dvd.org"

def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email,
         :subject => "Welcome to My Awesome Site")
  end
end
