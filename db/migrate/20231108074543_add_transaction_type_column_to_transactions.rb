class AddTransactionTypeColumnToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transaction_type, :string
  end
end
