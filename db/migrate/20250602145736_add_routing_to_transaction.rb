class AddRoutingToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :routing, :string
  end
end
