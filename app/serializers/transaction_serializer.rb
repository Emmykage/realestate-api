class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :coin_type, :status, :address, :transaction_type, :wallet, :receipt_url
  has_one :wallet
end
