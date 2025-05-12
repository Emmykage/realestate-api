class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions


  def deposit
      transactions.where(transaction_type: "deposit", status: "completed").sum(:amount)


  end

  def capital_growth
    transactions.joins(:portfolio).where(portfolios: {portfolio_name: "capital growth"}).sum(:amount)

  end
  def fixed_income
    transactions.joins(:portfolio).where(portfolios: {portfolio_name: "fixed income"}).sum(:amount)

  end


  def withdrawal
    if transactions.where(transaction_type: "withdraw").any?
      transactions.where(transaction_type: "withdraw").where(status: "completed").collect{|transaction| transaction.amount}.sum
    else
      0.0
    end
  end

  def wallet_balance
    (user.total_earnings - user.net_earnings + deposit) - (withdrawal + user.total_asset)
    end

end
