class UsersController < ApplicationController
	before_filter :authenticate_user!

	def index
    @title = "All Users"
    @users = User.all
  end
  
	def show
		@user 			= User.find(params[:id])
		@favorites  = @user.favorites
		@title 			= "User Profile: " + @user.name
	end

end
