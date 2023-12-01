class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :asset

  enum :status, {active: 0, inactive: 1}

  before_create :valid_transaction?


  def valid_transaction?
    raise ActiveRecord::RecordNotSaved, "You have limited funds in your wallet"  unless amount < user.wallet.wallet_balance
    true    
  end

  def investment_interest 
    0.0

    
  end
end
