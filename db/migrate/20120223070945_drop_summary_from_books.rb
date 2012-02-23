class DropSummaryFromBooks < ActiveRecord::Migration
  def change
  	remove_column 	:books, :summary
  	add_column		:books, :summary, :text
  end
end
