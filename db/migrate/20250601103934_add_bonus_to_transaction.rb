class AddBonusToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :bonus, :decimal
  end
end
