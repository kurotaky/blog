class RenameBodyColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :body, :content
  end
end
