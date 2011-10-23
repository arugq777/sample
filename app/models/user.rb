class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :username, :email, :password, :password_confirmation, :remember_me
  
  has_many	:favorite_books,	:dependent 		=>	:destroy,
  														:foreign_key	=>	"fan_id"
  													
  has_many 	:favorites, 			:through =>	:favorite_books,
  														:source => :favorites
end
