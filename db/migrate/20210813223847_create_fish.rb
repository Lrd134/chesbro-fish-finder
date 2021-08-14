class CreateFish < ActiveRecord::Migration[6.1]
  def change
    create_table :fish do |t|
      t.string :title
      t.string :image
      t.string :content
      t.boolean :solved
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
