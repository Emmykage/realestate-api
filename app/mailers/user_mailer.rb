class UserMailer < ApplicationMailer
    def confirmation_email(user)
        @user = user
        @confirmation_token = @user.confirmation_token
        @confirmation_url = confirmation_url(@user.confirmation_token, @user.email)
        @url = 'http://phoenix-realestate.com/login'
        attachments.inline['logo.jpg'] = File.read(Rails.root.join('app/assets/images/logo.jpg'))
        mail(to: @user.email, subject: "Confirmation Email")

    end

    def password_reset(user)
        @user = user
        @reset_password_url = reset_password_url(user.reset_password_token)
        mail(to: @user.email, subject: "Reset Password Instructions")
    end

    private

    def confirmation_url(confirmation_token, email)
        "#{Rails.application.config.action_mailer.default_url_options[:host]}/auth/confiirm-account?token=#{confirmation_token}&email=#{email}"
    end

    def reset_password_url(reset_password_token)
        "#{Rails.application.config.action_mailer.default_url_options[:host]}/auth/reset_password?password_token=#{reset_password_token}"
    end
end