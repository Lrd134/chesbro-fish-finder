class RemoveImagesFromFish < ActiveRecord::Migration[6.1]
  def change
    remove_column :fish, :image, :string
  end
end
