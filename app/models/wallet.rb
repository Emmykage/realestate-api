class Wallet < ApplicationRecord
  belongs_to :user
  has_many :portfolios, through: :user
  has_many :transactions, dependent: :destroy


  # def deposit
  #     transactions.where(transaction_type: "deposit", status: "completed").sum(&:transaction_total)
  # end

   def deposit
      transactions.where(transaction_type: "deposit", status: "completed").sum("COALESCE(amount, 0) + COALESCE(bonus, 0)")
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
      transactions.where(transaction_type: "withdraw", status: ["completed", "pending"]).sum(:amount)

  end


  def deactivated
    portfolios.where(status: :inactive).sum(:amount)

  end


  # def wallet_balance
  #   (user.total_earnings - user.net_earnings + deposit) - (withdrawal + user.total_asset)
  # end

  def wallet_balance
    portfolios.sum(&:total_investment) + deactivated - withdrawal
  end



    def virtual_balance
     portfolios.sum(&:total_investment) + deactivated - (virtual_withdrawal)
    #  virtual_withdrawal
    end


    def total_investment

      portfolios.sum(:amount)
    end


end
