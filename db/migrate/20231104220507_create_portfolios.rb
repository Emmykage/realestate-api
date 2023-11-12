class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios, id: :uuid do |t|
      t.decimal :amount
      t.boolean :paid, default: true #come back to this
      t.string :portfolio_name
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :asset, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
