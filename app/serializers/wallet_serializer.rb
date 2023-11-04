class WalletSerializer < ActiveModel::Serializer
  attributes :id, :balance
  has_one :user
end
