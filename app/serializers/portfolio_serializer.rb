class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :asset, :investment_interest, :status
  has_one :user
  has_one :asset
  has_many :portfolio_interests
end