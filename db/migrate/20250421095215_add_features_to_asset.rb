class AddFeaturesToAsset < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :features, :string, array: true, default: []
  end
end
