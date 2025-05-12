class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :investment_interest, :status, :portfolio_name, :name
  has_one :user
  has_one :investment
  has_many :portfolio_interests
end