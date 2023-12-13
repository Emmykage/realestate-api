class Api::V1::EarningsController < ApplicationController
  before_action :set_earning, only: %i[ show update destroy ]
  # before_action :initialize_earning

  # GET /earnings
  def index
    @earnings = Earning.all

    render json: @earnings
  end

  # GET /earnings/1
  def show
    render json: @earning
  end

  # POST /earnings
  def create
    @earning = Earning.new(earning_params)

    if @earning.save
      render json: @earning, status: :created, location: @earning
    else
      render json: @earning.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /earnings/1
  def update
    if @earning.update(earning_params)
      render json: @earning
    else
      render json: @earning.errors, status: :unprocessable_entity
    end
  end

  # DELETE /earnings/1
  def destroy
    @earning.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earning
      @earning = Earning.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def earning_params
      params.require(:earning).permit(:user_id)
    end
end
