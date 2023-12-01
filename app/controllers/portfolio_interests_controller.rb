class PortfolioInterestsController < ApplicationController
  before_action :set_portfolio_interest, only: %i[ show update destroy ]

  # GET /portfolio_interests
  def index
    @portfolio_interests = PortfolioInterest.all

    render json: @portfolio_interests
  end

  # GET /portfolio_interests/1
  def show
    render json: @portfolio_interest
  end

  # POST /portfolio_interests
  def create
    @portfolio_interest = PortfolioInterest.new(portfolio_interest_params)

    if @portfolio_interest.save
      render json: @portfolio_interest, status: :created, location: @portfolio_interest
    else
      render json: @portfolio_interest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /portfolio_interests/1
  def update
    if @portfolio_interest.update(portfolio_interest_params)
      render json: @portfolio_interest
    else
      render json: @portfolio_interest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /portfolio_interests/1
  def destroy
    @portfolio_interest.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio_interest
      @portfolio_interest = PortfolioInterest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portfolio_interest_params
      params.require(:portfolio_interest).permit(:interest, :portfolio_id)
    end
end
