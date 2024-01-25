class Transaction < ApplicationRecord
  has_one_attached :receipt
  belongs_to :wallet
  enum :coin_type, {BITCOIN: 0, ETHERUM: 1, "USD THETHER" => 2}
  enum :status, {pending: 0, completed: 1}
  enum :transaction_type, {deposit: 0, withdraw: 1}


  before_create :valid_transaction?
  

  def valid_transaction?
    # raise ActiveRecord::RecordNotSaved, "You have limited funds in your wallet"  unless amount < wallet.wallet_balance || transaction_type == "deposit"
    raise ActiveRecord::RecordNotSaved, "You have limited funds in your wallet"  unless amount < wallet.wallet_balance || transaction_type == "deposit"
    true    
  end
  # binding.b

  def receipt_url
    Rails.application.routes.url_helpers.url_for(receipt) if receipt.attached?
    
  end
  
end
