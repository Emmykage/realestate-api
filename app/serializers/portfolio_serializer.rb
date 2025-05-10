class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :investment_interest, :status
  has_one :user
  has_many :portfolio_interests
end