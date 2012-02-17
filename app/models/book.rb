class Book < ActiveRecord::Base
	attr_accessible :title, :author, :summary
	
	has_many	:favorited_books,
													:foreign_key => "favorited_id",
													:dependent => :destroy
													
	has_many 	:fans, 				:through	=>	:favorited_books,
  												:source		=>	:fan
  												
  def fan?(fan)
  	favorited_books.find_by_fan_id(fan)
  end
end
