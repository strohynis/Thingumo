class AddReferencesToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :category, null: false, foreign_key: true
  end
end
