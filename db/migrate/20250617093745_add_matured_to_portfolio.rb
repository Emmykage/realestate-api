class AddMaturedToPortfolio < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :matured, :boolean, default: false
  end
end
