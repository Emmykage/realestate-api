class UserMailer < ApplicationMailer
    def confirmation_email(user)
        @user = user
        # binding.b

        @confirmation_token = @user.confirmation_token
        @confirmation_url = confirmation_url(@user.confirmation_token)
        @url = 'http://phoenix-realestate.com/login'
        mail(to: @user.email, subject: "Confirmation Email")

    end

    def password_reset_instructions(user)
        @user = user
        @reset_password_url = reset_password_url(user.reset_password_token)
        mail(to: @user.email, subject: "Reset Password Instructions")
    end

    private

    def confirmation_url(confirmation_token)
        "#{Rails.application.config.action_mailer.default_url_options[:host]}/confirm_email?confirmation_token=#{confirmation_token}"
    end

    def reset_password_url(reset_password_token)
        "#{Rails.application.config.action_mailer.default_url_options[:host]}/reset_password?password_token=#{reset_password_token}"
    end
end