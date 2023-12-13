class CreateEarningTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :earning_transactions, id: :uuid do |t|
      t.decimal :amount, default: 0
      t.references :earning, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
