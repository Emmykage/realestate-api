class PortfolioInterestSerializer < ActiveModel::Serializer
  attributes :id, :interest, :compounded, :created_at
  has_one :portfolio
end
