class Api::V1::AccountProfilesController < ApplicationController
  before_action :set_account_profile, only: %i[ show update destroy ]

  # GET /account_profiles
  def index
    @account_profiles = AccountProfile.last
    render json: { data: AccountProfileSerializer.new(@account_profiles)}
  end

  # GET /account_profiles/1
  def show
    render json: {data: AccountProfileSerializer.new(@account_profile)}
  end

  # POST /account_profiles
  def create
    @account_profile = AccountProfile.new(account_profile_params)

    if @account_profile.save
      render json:{data:  @account_profile}, status: :created
    else
      render json: {message: @account_profile.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /account_profiles/1
  def update
    if @account_profile.update(account_profile_params)
      render json: {data: @account_profile}
    else
      render json: {message: @account_profile.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  # DELETE /account_profiles/1
  def destroy
    @account_profile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_profile
      @account_profile = AccountProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_profile_params
      params.require(:account_profile).permit(:bank, :bitcoin, :ethereum, :usdt)
    end
end
