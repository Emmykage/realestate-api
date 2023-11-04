class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :portfolio_name
  has_one :user
  has_one :asset
end
