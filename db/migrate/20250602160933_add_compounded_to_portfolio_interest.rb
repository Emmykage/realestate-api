class AddCompoundedToPortfolioInterest < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolio_interests, :compounded, :boolean, default: false
  end
end
