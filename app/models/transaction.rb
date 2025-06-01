class Transaction < ApplicationRecord
  has_one_attached :receipt
  belongs_to :wallet
  belongs_to :portfolio, optional: true
  has_one :user, through: :wallet
  enum :coin_type, {bitcoin: 0, ethereum: 1, usdt: 2, bank: 3, bnb: 4}
  enum :status, {pending: 0, completed: 1, declined: 2}
  enum :transaction_type, {deposit: 0, withdraw: 1}


  validate :valid_transaction?, if: :isWithdraw?


  def valid_transaction?
    errors.add(:amount, "you have limited funds ") if amount > wallet.wallet_balance
  end

  def receipt_url
    Rails.application.routes.url_helpers.url_for(receipt) if receipt.attached?
  end

  def transaction_total
    amount + (bonus || 0)
  end



  def isWithdraw?
    transaction_type == "withdraw"
  end

end
