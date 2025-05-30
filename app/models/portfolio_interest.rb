class PortfolioInterest < ApplicationRecord
  belongs_to :portfolio
  before_create :generate_interest


  def generate_interest
    if portfolio.portfolio_investment > 0
      calc_interest
    else
      errors.add(:interest, "no investment has been made by client")
    end

  end

  def generate_interest

    if interest.present?
      self.interest = (interest / 100) * portfolio.portfolio_investment
    else
      calc_interest
    end
  end




  private
  def calc_interest
    if  portfolio.portfolio_name == "capital growth"
      self.interest = portfolio.portfolio_investment * 0.05
    elsif portfolio.portfolio_name == "fixed income"
      self.interest = portfolio.portfolio_investment * 0.03
    else
      self.interest = 0.0
    end
  end

end
