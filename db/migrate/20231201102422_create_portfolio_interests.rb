class CreatePortfolioInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_interests, id: :uuid do |t|
      t.decimal :interest
      t.references :portfolio, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
