class Api::V1::PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[ show update destroy re_invest compound_interest ]
  before_action :authorize

  # GET /portfolios
  def index
    @portfolios = Portfolios.all

    render json: {data: ActiveModelSerializers::SerializableResource.new(@portfolios)}, status: :ok
  end

  def user
    @portfolios = @current_user.portfolios.all

    render json: {data: ActiveModelSerializers::SerializableResource.new(@portfolios)}, status: :ok
  end
  def portfolio_index
    user = User.find(params[:id])
    portfolios = user.portfolios
    render json: portfolios

  end

  # GET /portfolios/1
  def show
    render json: {data: @portfolio}
  end




  def investment

    investmentId  = params[:id]
    @current_user.create_portfolios if @current_user.portfolios.blank?

    # @portfolio =  @current_user.portfolios.joins(:investment).find_by(investments: {name: investmentId})
    @portfolio =  @current_user.portfolios.where(status: :active).joins(:investment).find_by(investments: {name: investmentId})
    # @portfolio =  @current_user.portfolios.find_by(name: investmentId)
    render json: {data: PortfolioSerializer.new(@portfolio)}, status: :ok
  end

  # POST /portfolios
  def create
    @portfolio = @current_user.portfolios.new(portfolio_params)

    if @portfolio.save
      render json: @portfolio, status: :created
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  def re_invest

   prev_amount = @portfolio.amount
   comulative_amount = @portfolio.comulated_return

   if comulative_amount > @portfolio.wallet.virtual_balance
      return render json: {message: "you have insufficient funds"}, status: :unprocessable_entity
    end

   portfolio_name = @portfolio.portfolio_name || @portfolio.name


    unless  @portfolio.matured
      return render json: {message: "portfolio not yet matured"}, status: :unprocessable_entity
    end

   if @portfolio.update(status: :inactive)
      investment_id =  @portfolio.investment_id
      portfolio = @current_user.portfolios.create(investment_id: investment_id, portfolio_name: portfolio_name , amount: prev_amount + comulative_amount, comulative_amount: comulative_amount, re_invest: true)

   if portfolio.save
      render json: {data: portfolio, message: "re invested"}, status: :created
    else

      render json: {message: portfolio.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end

  else
     render json: {message: @portfolio.errors.full_messages.to_sentence}, status: :unprocessable_entity

  end

  end


  # PATCH/PUT /portfolios/1
  def update
    if @portfolio.update(portfolio_params)
      render json: {data: @portfolio, message: "Portfolio Updated"}, status: :ok
    else
      render json: @portfolio.errors, status: :unprocessable_entity
    end
  end

  def compound_interest

   if @portfolio.portfolio_interests.update_all(compounded: true)
     render json: {data: @portfolio, message: "Portfolio interests Compounded"}, status: :ok
   else
    render json: {message: @portfolio.errors.full_messages.to_sentence}, status: :ok

   end


  end

  # DELETE /portfolios/1
  def destroy
    @portfolio.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portfolio_params
      params.require(:portfolio).permit(:amount, :paid, :matured, :portfolio_name)
    end
end
