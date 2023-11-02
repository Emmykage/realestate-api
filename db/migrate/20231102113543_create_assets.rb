class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets, id: :uuid do |t|
      t.string :name
      t.string :address
      t.string :tenure
      t.string :sale_type
      t.string :area
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms
      t.decimal :price
      t.string :images
      t.string :status

      t.timestamps
    end
  end
end
