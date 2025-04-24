class AddMainPhotoToAssets < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :mainphoto, :string
  end
end
