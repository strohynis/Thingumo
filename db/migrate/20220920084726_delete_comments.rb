class DeleteComments < ActiveRecord::Migration[5.2]
  def change
    drop_table :comments
  end
end
