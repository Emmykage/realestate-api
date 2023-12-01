class AddInterestToPortfolios < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :interest, :decimal
  end
end
