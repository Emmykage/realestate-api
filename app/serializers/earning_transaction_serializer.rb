class EarningTransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount
  has_one :earning
end
