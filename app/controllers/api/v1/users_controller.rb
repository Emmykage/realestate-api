class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authorize, only: [:index, :show, :update, :account, :update_account]


  # GET /users
  def index
    @users = User.all

    render json: {data: ActiveModelSerializers::SerializableResource.new(@users)}, status: :ok
  end

  # GET /users/1
  def show
    render json: {data: UserSerializer.new(@user)}, status: :ok

  end

  def account
    render json: {data: UserSerializer.new(@current_user)}, status: :ok
  end

  # POST /users
  def create
    @current_user = User.create(user_params)

    if @current_user.valid?
      # UserMailer.with(user: @user).confirmation_email.deliver_later

      token = encode_token({user_id: @current_user.id})
      render json: {data: @current_user, token: token},  status: :created

    else
      # render json: @user.errors, status: :unprocessable_entity
      render json: { message: @current_user.errors.full_messages.to_sentence}, status: :unprocessable_entity

    end
  end


  def login
    @current_user = User.find_by(email: user_params[:email].downcase)
    if @current_user
      initialize_wallet
      initialize_earning


      if @current_user.authenticate(user_params[:password])
        @current_user.create_portfolios  if @current_user.portfolios.blank?
        token = encode_token({user_id: @current_user.id})
        render json: {user: @current_user, token: token}, status: :ok
      else
        render json: {message: "Invalid user or password"}, status: :unprocessable_entity
     end
    else
      render json: {message: "user does not exist", message: "user does not exist"}, status: :unprocessable_entity
    end
  end

    def confirm_account

     current_user = User.find_by(email: params[:email]&.downcase)

  # Return immediately if user not found
    unless current_user
     render json: { message: "User not found" }, status: :not_found
    end

  # Check if already confirmed
    if current_user.confirmed_at.present?
     render json: { message: "Account already confirmed" }, status: :unprocessable_entity
    end

  # Verify token
  unless current_user.confirmation_token.present? &&
         current_user.confirmation_token == params[:token]
     render json: { message: "Invalid confirmation token" }, status: :unprocessable_entity
  end

  if current_user.update(confirmed_at: Time.now, confirmation_token: nil)
        token = encode_token({user_id: current_user.id})
          render json: {user: current_user, token: token, message: "account confirmed"}, status: :ok
        else
          render json: {message: current_user.errors.full_messages.to_sentence}, status: :unprocessable_entity
      end

  end


  def forgot_password
    user = User.find_by(email: params[:email])
    if user
      user.generate_reset_password_token
      UserMailer.password_reset_instructions(user).deliver_now
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

  # PATCH/PUT /users/1
  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

 def update_account

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @current_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :role, :password, profile_attributes: %i[investment_purpose investment_property initial_investment investor_type])
    end
end
