class FavoritedBooksController < ApplicationController
	before_filter :authenticate_user!
	
	def create
		@book = Book.find( params[:favorited_book][:favorited_id] )
		current_user.add_favorite!(@book)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
	
	def destroy
		@favorite = FavoritedBook.find(params[:id])
		@book= Book.find(@favorite.favorited_id)
		current_user.del_favorite!(@favorite)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end