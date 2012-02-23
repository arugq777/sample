class DropTableBooks < ActiveRecord::Migration
  def up
  	drop_table :books
  	create_table :books do |t|
  		t.string :title
		t.string :author
		t.text :summary
		t.timestamps
  	end
  end

  def down
  end
end
