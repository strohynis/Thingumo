class RemoveImagesFromPostImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_images, :image
  end
end
