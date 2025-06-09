class Transaction < ApplicationRecord
  has_one_attached :receipt
  belongs_to :wallet
  belongs_to :portfolio, optional: true
  has_one :user, through: :wallet
  enum :coin_type, {bitcoin: 0, ethereum: 1, usdt: 2, bank: 3, bnb: 4}
  enum :status, {pending: 0, completed: 1, declined: 2}
  enum :transaction_type, {deposit: 0, withdraw: 1}


  validate :valid_transaction?, if: :isWithdraw?

  after_update :add_portfolio_amount, if: :is_status_completed?


  def valid_transaction?
    errors.add(:amount, "you have limited funds ") if amount > wallet.wallet_balance
  end

  def receipt_url
    Rails.application.routes.url_helpers.url_for(receipt) if receipt.attached?
  end

  def transaction_total
    amount + (bonus || 0)
  end

  def is_status_completed?
    status &&  status == "completed"
  end


  def add_portfolio_amount
    portfolio_amount = portfolio.approved_transaction_deposit
    portfolio.update(amount: portfolio_amount )
  end






  def isWithdraw?
    transaction_type == "withdraw"
  end

end
