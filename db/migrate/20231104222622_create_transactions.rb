class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.decimal :amount
      t.integer :coin_type
      t.integer :status
      t.string :address
      t.references :wallet, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
