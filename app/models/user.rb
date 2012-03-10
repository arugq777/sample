class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :username, :email, :password, :password_confirmation, :remember_me
  
  has_many :favorited_books, :dependent   => :destroy,
                             :foreign_key => "fan_id"

  has_many :favorites, :through => :favorited_books,
                       :source  => :favorited

  validates :password, :length  => { :maximum => 50 }

  validates :name,     :length  => { :maximum => 50 }

  validates :username, :presence   => true,
                       :uniqueness => { :case_sensitive => false },
                       :length     => { :maximum => 25 }

  def favorite?(book)
    favorited_books.find_by_favorited_id(book)
  end
  
  def add_favorite!(book)
    if not favorite?(book)
      favorited_books.create!( :favorited_id => book.id )
    end
  end
  
  def del_favorite!(favorite)
    favorited_books.find_by_id(favorite.id).destroy
  end
end
