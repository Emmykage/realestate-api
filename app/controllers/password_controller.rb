class PasswordController < ApplicationController
  


    def reset_password 
        user  = User.find_by(reset_password_token: params[:reset_password_token])
        if user && user.reset_password_sent_at > 1.hour.ago 
        user.update(password: params[:password], reset_password_token: nil, reset_password_sent_at: nil)
        render json: {message: "Password reset successfully"}
        else 
        render json: {errors: "invalid or expired password token"}, status: :unprocessable_entity
        end 
  end

end