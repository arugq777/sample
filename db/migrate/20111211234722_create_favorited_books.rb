class CreateFavoritedBooks < ActiveRecord::Migration
  def change
    create_table :favorited_books do |t|
      t.integer :fan_id
      t.integer :favorited_id

      t.timestamps
    end
  end
end
