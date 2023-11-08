class WalletSerializer < ActiveModel::Serializer
  attributes :id, :wallet_balance, :transactions, :total, :withdrawal, :deposit
  has_one :user
  has_many :transactions
end
