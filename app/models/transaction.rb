class Transaction < ApplicationRecord
  belongs_to :wallet
  enum :coin_type, {BITCOIN: 0, ETHERUM: 1, "USD THETHER" => 2}
  enum :status, {pending: 0, completed: 1}

  before_create :valid_transaction?
  

  def valid_transaction?
    raise ActiveRecord::RecordNotSaved, "You have limited funds in your wallet"  unless amount < wallet.wallet_balance
    true    
  end
  
end
