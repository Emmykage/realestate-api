class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions


  def deposit
      transactions.where(transaction_type: "deposit", status: "completed").sum(:amount)


  end

  def virtual_deposit
      transactions.where(transaction_type: "deposit", status: ["completed", "pending"]).sum(:amount)


  end


  def capital_growth
    transactions.joins(:portfolio).where(portfolios: {portfolio_name: "capital growth"}).sum(:amount)

  end
  def fixed_income
    transactions.joins(:portfolio).where(portfolios: {portfolio_name: "fixed income"}).sum(:amount)

  end

  def calculated_investment
    fixed_income + capital_growth

  end








  def withdrawal
      transactions.where(transaction_type: "withdraw", status: "completed").sum(:amount)

  end
  def virtual_withdrawal
      transactions.where(transaction_type: "withdraw", status: "completed").sum(:amount)

  end

  def wallet_balance
    (user.total_earnings - user.net_earnings + deposit) - (withdrawal + user.total_asset)
    end

    def virtual_balance
    (user.total_earnings - user.net_earnings + virtual_deposit) - (virtual_withdrawal + user.total_asset)
    end

end
