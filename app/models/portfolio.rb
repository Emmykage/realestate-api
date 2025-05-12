class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_interests
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


  def investment_interest
    # if portfolio_interests.any?
    #   portfolio_interests.collect{|profit| profit.interest}.sum
    #   else
    #   0.0
    # end

    0.0

  end
end
