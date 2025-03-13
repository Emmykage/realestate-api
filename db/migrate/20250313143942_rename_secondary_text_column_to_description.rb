class RenameSecondaryTextColumnToDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :blogs, :secondary_text, :description
    remove_column :blogs, :body
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
