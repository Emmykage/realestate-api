class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :coin_type, :status, :address
  has_one :wallet
end
