class Api::V1::InvestmentsController < ApplicationController
  before_action :set_investment, only: %i[ show update destroy ]

  # GET /investments
  def index
    @investments = Investment.all


    render json: {data: @investments}
  end

  # GET /investments/1
  def show
    render json: @investment
  end

  # POST /investments
  def create
    @investment = Investment.new(investment_params)

    if @investment.save
      render json: @investment, status: :created, location: @investment
    else
      render json: @investment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /investments/1
  def update
    if @investment.update(investment_params)
      render json: @investment
    else
      render json: @investment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /investments/1
  def destroy
    @investment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment
      @investment = Investment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment).permit(:name, :min_value)
    end
end
