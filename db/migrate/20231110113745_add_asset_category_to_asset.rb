class AddAssetCategoryToAsset < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :asset_category, :string, default: 0
  end
end
