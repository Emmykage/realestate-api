class Api::V1::WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show update destroy ]
  before_action :authorize

  # GET /wallets
  def index
    @wallets = Wallet.all

    render json: @wallets
  end

  # GET /wallets/1
  def show
    render json: @wallet
  end

  # POST /wallets
  # def create
  #   @wallet = Wallet.new(wallet_params)

  #   if @wallet.save
  #     render json: @wallet, status: :created, location: @wallet
  #   else
  #     render json: @wallet.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /wallets/1
  def update
    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wallets/1
  def destroy
    @wallet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:balance, :user_id)
    end
end
