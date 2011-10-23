class Book < ActiveRecord::Base
	attr_accessible :title, :author
	
	has_many	:fans_favoriting,
													:foreign_key => "favorited_id",
													:class_name => "FavoriteBooks",
													:dependent => :destroy
													
	has_many 	:fans, 				:through	=>	:fans_favoriting,
  												:source		=>	:fans
end
