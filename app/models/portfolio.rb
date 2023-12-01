class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :asset
  has_many :portfolio_interests

  enum :status, {active: 0, inactive: 1}

  before_create :valid_transaction?


  def valid_transaction?
    raise ActiveRecord::RecordNotSaved, "You have limited funds in your wallet"  unless amount < user.wallet.wallet_balance
    true    
  end

  def investment_interest 
    if portfolio_interests.any?
    portfolio_interests.collect{|profit| profit.interest}.sum
      else
      0.0
    end
    
  end
end
