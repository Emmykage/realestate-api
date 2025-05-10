class AccountProfileSerializer < ActiveModel::Serializer
  attributes :id, :bank, :bitcoin, :ethereum, :usdt
end
