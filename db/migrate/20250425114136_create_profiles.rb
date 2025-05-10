class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :investment_purpose
      t.string :investment_property
      t.decimal :initial_investment
      t.string :investor_type
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
