class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]
  before_action :authorize
  # before_action :

  # GET /transactions
  def index
    @transactions = Transaction.all

    @transactions = @transactions.where(transaction_type: params[:transaction_type]) if params[:transaction_type].present?
    @transactions = @transactions.where(coin_type: params[:coin_type]) if params[:coin_type].present?

    render json: {data:   ActiveModelSerializers::SerializableResource.new(@transactions)}, status: :ok
  end

  def user

    @transactions = @current_user.transactions
    @transactions = @transactions.where(transaction_type: params[:transaction_type]) if params[:transaction_type].present?
    @transactions = @transactions.where(coin_type: params[:coin_type]) if params[:coin_type].present?

    render json: {data:   ActiveModelSerializers::SerializableResource.new(@transactions)}, status: :ok

  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = @current_user.wallet.transactions.new(transaction_params)

    if @transaction.save
      TransactionMailer.send_notification(@current_user, @transaction).deliver_now
      render json: {data: @transaction}, message: "transaction created", status: :created
    else
      render json: {message: @transaction.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: {data: @transaction, message: "update successfull"}, status: :ok
    else
      render json: {messsage: @transaction.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:amount, :coin_type, :status, :address, :transaction_type, :receipt, :portfolio_id, :bonus, :routing ).tap do |permitted|
        permitted[:receipt] = nil if permitted[:receipt] == ""
      end
    end
end
