class FavoriteBook < ActiveRecord::Base
	attr_accessible :fan_id, :favorited_id
	
	belongs_to 	:fan, 			:class_name 	=> "User"
	belongs_to 	:favorited, :class_name 	=> "Book" 
	
	validates :fan_id, 				:presence 	=> true
	validates :favorited_id,	:presence 	=> true
end
