class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.belongs_to :fish, null: false, foreign_key: true
      t.string :body
      t.timestamps
    end
  end
end
