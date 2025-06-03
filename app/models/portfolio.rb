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


  def cal_portfolio_investment
    transactions.sum(:amount)
  end

  def portfolio_investment
    cal_portfolio_investment + compounded_investment_interest
  end


  def investment_interest
    portfolio_interests.where(compounded: false).sum(:interest)
  end

     def compounded_investment_interest
      portfolio_interests.where(compounded: true).sum(:interest)
    end
end
