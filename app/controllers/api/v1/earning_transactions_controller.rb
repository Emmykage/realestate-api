class Api::V1::EarningTransactionsController < ApplicationController
  before_action :set_earning_transaction, only: %i[ show update destroy ]
  before_action :authorize
  before_action :initialize_earning


  # GET /earning_transactions
  def index
    @earning_transactions = @earning.earning_transactions.all
    render json: @earning_transactions
  end

  # GET /earning_transactions/1
  def show
    render json: @earning_transaction
  end

  # POST /earning_transactions
  def create

    @earning_transaction = @earning.earning_transactions.new(earning_transaction_params)

    if @earning_transaction.save
      render json: @earning_transaction, status: :created
    else
      render json: @earning_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /earning_transactions/1
  def update
    if @earning_transaction.update(earning_transaction_params)
      render json: @earning_transaction
    else
      render json: @earning_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /earning_transactions/1
  def destroy
    @earning_transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earning_transaction
      @earning_transaction = EarningTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def earning_transaction_params
      params.require(:earning_transaction).permit(:amount)
    end
end
