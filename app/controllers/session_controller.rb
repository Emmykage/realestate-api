class SessionController < ApplicationController
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
end
