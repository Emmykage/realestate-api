class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs, id: :uuid do |t|
      t.string :title
      t.string :secondary_text
      t.text :body
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
