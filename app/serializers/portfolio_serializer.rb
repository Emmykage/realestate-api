class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :amount, :matured, :paid, :investment_interest, :status, :portfolio_name, :name, :maturity, :total_investment, :virtual_total_investment, :portfolio_value
  has_one :user
  has_one :investment
  has_many :portfolio_interests
end