class RegistrationController < ApplicationController
  


    def create
      @current_user = User.create(user_params)
  
      if @current_user.valid?      
        UserMailer.with(user: @user).confirmation_email.deliver_later
  
        token = encode_token({user_id: @current_user.id})
        initialize_wallet
        initialize_earning
  
        # render json:{user: @current_user, token: token},  status: :created
        render json: { success: 'confirmation email send' }, status: :ok
      else
        # render json: @user.errors, status: :unprocessable_entity
        render json: { error: 'Invalid user or password', message: @current_user.errors}, status: :unprocessable_entity
  
      end
    end
  
  
    def login 
      @current_user = User.find_by(email: user_params[:email])
      initialize_wallet
      initialize_earning
  
      if @current_user && @current_user.authenticate(user_params[:password])
        token = encode_token({user_id: @current_user.id})
        render json: {user: @current_user, token: token}, status: :ok
      else
        render json: {error: "invalid user or password", message: @current_user.errors}, status: :unprocessable_entity
  
      end 
    end
  
    def confirm_email 
      user = User.find_by(confirmation_token: params[:confirmation_token])
      if user && !user.confirmed?
        # user.email_confirmation
        user.update(confirmed_at: Time.current, confirmation_token: nil)

        render json: { message: 'Email confirmed successfully'}
      else 
        render json: {error: 'Invalid confirmation token'}, status: :unprocessable_entity
  
      end
      
    end
    
    def forgot_password 
      user = User.find_by(email: params[:email])
      if user 
        user.generate_reset_password_token
        UserMailer.reset_password_instructions(user).deliver_now 
        render json: {message: "Reset password Instructions sent. Please check your mail box"}
      else 
        render json: {errors: "user not found with the email"}, status: :unprocessable_entity
      end
      
    end
    def reset_password 
      user  = User.find_by(reset_password_token: params[:reset_password_token])
      if user && user.reset_password_sent_at > 1.hour.ago 
        user.update(password: params[:password], reset_password_token: nil, reset_password_sent_at: nil)
      else 
        render json: {errors: "invalid or expired password token"}, status: :unprocessable_entity
      end 
    end
  
    
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :role, :password)
      end
  end
  