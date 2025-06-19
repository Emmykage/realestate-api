class Transaction < ApplicationRecord
  has_one_attached :receipt
  belongs_to :wallet
  belongs_to :portfolio, optional: true
  has_one :user, through: :wallet
  enum :coin_type, {bitcoin: 0, ethereum: 1, usdt: 2, bank: 3, bnb: 4}
  enum :status, {pending: 0, completed: 1, declined: 2}
  enum :transaction_type, {deposit: 0, withdraw: 1}

  default_scope { order(created_at: :desc) }


  validate :valid_transaction?, if: :isWithdraw?, on: :create

  before_update :add_portfolio_amount, if: :is_status_completed?
  after_update :confirm_transaction_mail

  def confirm_transaction_mail
    TransactionMailer.confirm_transaction(user, self).deliver_now
  end

  def valid_transaction?
    errors.add(:amount, "you have limited funds ") if amount > wallet.virtual_balance
  end

  def receipt_url
    Rails.application.routes.url_helpers.url_for(receipt) if receipt.attached?
  end

  def transaction_total
    amount + (bonus || 0)
  end

  def is_status_completed?
    status &&  status == "completed" && transaction_type == "deposit"
  end


  def add_portfolio_amount

    total_deposit = portfolio.approved_transaction_deposit

    prev_amount = portfolio.amount || 0.0
    portfolio_amount = total_deposit == 0.0 ? prev_amount + amount : total_deposit + portfolio.amount

    portfolio.update(amount: portfolio_amount )
  end






  def isWithdraw?
    transaction_type == "withdraw"
  end

end
