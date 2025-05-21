class WalletSerializer < ActiveModel::Serializer
  attributes :id, :wallet_balance, :transactions, :withdrawal, :deposit, :capital_growth, :fixed_income, :virtual_balance, :virtual_withdrawal
  has_one :user
  has_many :transactions
end
