class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_no
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
  end
end
