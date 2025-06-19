class Portfolio < ApplicationRecord
  attr_accessor :re_invest, :comulative_amount
  belongs_to :user
  has_many :portfolio_interests, dependent: :destroy
  has_many :transactions, dependent: :destroy


  belongs_to :investment
  has_one :wallet, through: :user

  enum :status, {active: 0, inactive: 1}
  # enum :portfolio_name, {"capital growth" => 0, "fixed income" => 1}
  # validate :valid_transaction, if: :re_investing?

  default_scope {order(created_at: :desc )}


    def valid_transaction
      errors.add(:amount, "you have limited funds ") if comulative_amount > (wallet.virtual_balance)
    end


  def name
    investment.name
  end

  def maturity
    time =  transactions.first&.created_at
    return false if time.nil?
    3.months.ago > time
  end

   def approved_transaction_deposit
    transactions.where(status: :completed, transaction_type: :deposit).sum(:amount)
  end

  def all_transaction_deposit
    transactions.where(status: %i[completed pending], transaction_type: :deposit).sum(:amount)
  end

  def cal_portfolio_investment
    transactions.sum(:amount)
  end

  def total_investment
   compounded_investment_interest
  end

  def comulated_return
   compounded_investment_interest
  end

  def virtual_total_investment
   compounded_investment_interest + all_transaction_deposit - (amount || 0)
  end

  def portfolio_value
    if portfolio_name == "fixed income"
      amount
      else
        (amount || 0) + compounded_investment_interest
    end
  end



  # def portfolio_investment
  #   approved_transaction_deposit + compounded_investment_interest - (amount || 0)
  # end


  def investment_interest
    portfolio_interests.where(compounded: false).sum(:interest)
  end

     def compounded_investment_interest
      portfolio_interests.where(compounded: true).sum(:interest)
    end


    def re_investing?
      re_invest.present? && re_invest == true

    end
    private


end
