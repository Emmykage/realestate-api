class Transaction < ApplicationRecord
  has_one_attached :receipt
  belongs_to :wallet
  belongs_to :portfolio
  enum :coin_type, {bitcoin: 0, ethereum: 1, usdt: 2, bank: 3}
  enum :status, {pending: 0, completed: 1}
  enum :transaction_type, {deposit: 0, withdraw: 1}


  before_create :valid_transaction?


  def valid_transaction?

    errors.add(:amount, "you have limited funds ") unless amount < wallet.wallet_balance || transaction_type == "deposit"
    true
  end

  def receipt_url
    Rails.application.routes.url_helpers.url_for(receipt) if receipt.attached?

  end

end
