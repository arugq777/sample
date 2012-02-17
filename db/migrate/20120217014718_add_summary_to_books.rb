class AddSummaryToBooks < ActiveRecord::Migration
  def change
    add_column :books, :summary, :text, :limit => 65536
  end
end
