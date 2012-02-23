require 'spec_helper'

describe FavoritedBook do

	before(:each) do
		@book = Factory(:book)
		@user = Factory(:user)
		@favorite = @user.favorited_books.build( :favorited_id => @book.id )
	end
	
	it "should create a new instance given valid attributes" do
		@favorite.save!
	end
  
	describe "follow methods" do
		before(:each) do
			@favorite.save
		end
		
		it "should have a fan attribute" do
			@favorite.should respond_to(:fan)
		end
		
		it "should have the right follower" do
			@favorite.fan.should == @user
		end
		
		it "should have a favorited attribute" do
			@favorite.should respond_to(:favorited)
		end
		
		it "should have the right favorited book" do
			@favorite.favorited.should == @book
		end
	end
	
	describe "validations" do
		
		it "should require a fan_id" do
			@favorite.fan_id = nil
			@favorite.should_not be_valid
		end
		
		it "should require a favorited_id" do
			@favorite.favorited_id = nil
			@favorite.should_not be_valid
		end
		
	end
end
