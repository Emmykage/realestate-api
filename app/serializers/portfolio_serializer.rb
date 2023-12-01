class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :asset, :investment_interest
  has_one :user
  has_one :asset
end