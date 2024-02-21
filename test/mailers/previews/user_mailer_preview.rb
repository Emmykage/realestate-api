# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def welcome_email
        user = User.new(first_name: "Joe", last_name: "smith", email: "info@melisport.com")

        UserMailer.with(user: user).welcome_email
    end

end
