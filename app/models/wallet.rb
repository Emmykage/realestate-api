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
   portfolios.where(portfolio_name: "fixed income").sum(:amount)

  end



  def calculated_investment
    portfolios.where(status: :active).sum(:amount)

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


   def withdrawn_portfolio
    portfolios.where(status: :withdrawn).sum(:amount)

  end

    def activated
    portfolios.where(status: :active).sum(:amount)

  end


  # def wallet_balance
  #   (user.total_earnings - user.net_earnings + deposit) - (withdrawal + user.total_asset)
  # end

  def wallet_balance
    portfolios.where(portfolio_name: "fixed income", status: :withdrawn).sum(&:comulated_return)  + withdrawn_portfolio - withdrawal
  end



    def virtual_balance
        portfolios.where(portfolio_name: "fixed income", status: :withdrawn).sum(&:comulated_return) + withdrawn_portfolio - (virtual_withdrawal)
    end

    def virtual_comulative_balance
      portfolios.where(portfolio_name: "fixed income", status: :active).sum(&:comulated_return)
    end



    def total_investment

      portfolios.sum(:amount)
    end


end
