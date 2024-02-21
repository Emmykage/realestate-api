class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authorize, only: [:index, :show, :update, :account, :update_account]


  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def account
    render json: @current_user
    
  end

  # POST /users
  def create
    @current_user = User.create(user_params)

    if @current_user.valid?      
      UserMailer.with(user: @user).confirmation_email.deliver_later

      token = encode_token({user_id: @current_user.id})
      initialize_wallet
      render json:{user: @current_user, token: token},  status: :created
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
      params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :role, :password)
    end
end
