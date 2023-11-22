class AddCityColumnToAsset < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :city, :integer, default: 0
  end
end
