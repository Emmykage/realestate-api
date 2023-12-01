class AddWithdrawnToPortfolioInterests < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolio_interests, :withdrawn, :boolean, default: false
  end
end
