class AccountProfileSerializer < ActiveModel::Serializer
  attributes :id, :bank, :address, :name, :account_type, :routing
end
