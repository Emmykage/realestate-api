class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :coin_type, :status, :address, :transaction_type
  has_one :wallet
end
