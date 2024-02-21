class UserMailer < ApplicationMailer
    def confirmation_email 
        @user = params[:user]
        @url = 'http://phoenix-realestate.com/login'
        mail(to: @user.email, subject: "Confirmation Email")

    end
end
