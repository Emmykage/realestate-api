class AddNameToAccountProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :account_profiles, :name, :string
    add_column :account_profiles, :address, :string
    add_column :account_profiles, :routing, :string
    add_column :account_profiles, :account_type, :integer, default: 0
  end
end
