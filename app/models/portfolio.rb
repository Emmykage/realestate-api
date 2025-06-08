class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_interests
  has_many :transactions


  belongs_to :investment

  enum :status, {active: 0, inactive: 1}

  # before_create :valid_transaction?


  # def valid_transaction?
  #   raise ActiveRecord::RecordNotSaved, "You have limited funds in your wallet"  unless amount < user.wallet.wallet_balance
  #   true
  # end



  def valid_transaction?
    if amount > user.wallet.wallet_balance
      errors.add(:amount, "insufficient balance" )
    end
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
   compounded_investment_interest + approved_transaction_deposit - (amount || 0)
  end

  def virtual_total_investment
   compounded_investment_interest + all_transaction_deposit - (amount || 0)
  end


  def portfolio_investment
    approved_transaction_deposit + compounded_investment_interest - (amount || 0)
  end


  def investment_interest
    portfolio_interests.where(compounded: false).sum(:interest)
  end

     def compounded_investment_interest
      portfolio_interests.where(compounded: true).sum(:interest)
    end
end
