class AddTypesToAsset < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :property_type, :string
  end
end
