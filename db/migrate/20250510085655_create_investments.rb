class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments, id: :uuid do |t|
      t.string :name
      t.decimal :min_value

      t.timestamps
    end
  end
end
