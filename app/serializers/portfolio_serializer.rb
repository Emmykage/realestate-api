class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :paid, :investment_interest, :status, :portfolio_name, :name, :portfolio_investment, :maturity, :total_investment, :virtual_total_investment
  has_one :user
  has_one :investment
  has_many :portfolio_interests
end