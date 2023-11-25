class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :asset
  has_one :user
  has_one :asset
end