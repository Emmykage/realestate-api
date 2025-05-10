class CreateAccountProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :account_profiles, id: :uuid do |t|
      t.string :bank
      t.string :bitcoin
      t.string :ethereum
      t.string :usdt

      t.timestamps
    end
  end
end
