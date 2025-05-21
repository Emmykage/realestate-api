class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :coin_type, :status, :address, :transaction_type, :wallet, :receipt_url, :created_at, :user
  has_one  :portfolio
  has_one :wallet
end
