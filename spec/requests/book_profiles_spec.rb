require 'spec_helper'

describe "BookProfiles" do
	
	before(:each) do
		@book1 = Factory(:book)
		@book2 = Factory(:book, :title => "book2")
		@user1 = Factory(:user)
		@user2 = Factory(:user, :username => "user2",
														:email 		=> "user2@example.com")
	end
	
	describe "GET books" do

		before(:each) do
			get "/books"
		end
		it "should get books page" do
			response.should have_selector( :h2, :content => "The Catalogue")
		end
		
		it "should have the correct title, too" do
			response.should have_selector( :title, :content => "All Books")
		end
    
    it "should list number of fans" do
    	response.should have_selector( "span.book_stat1", :content => "0")
    	response.should have_selector( "td.stats", :content => "fans")
    end
    
  end
  
  describe "book profile" do

  	before(:each) do
  		@user1.favorited_books.create( :favorited_id => @book1.id )
  		get "/books/#{@book1.id}"
  	end
  	
  	it "should list fan count" do
  		response.should have_selector( "span.book_stat1", :content => "1")
    	response.should have_selector( "div.stats", :content => "fans")
  	end
  	it "should list fan names" do
  		response.should have_selector( 	"ul#book_fans li a", 
  																		:content=> "#{@user1.username}")
			
  	end
  	
  	it "should have title, author, and summary" do
  		response.should have_selector( :h2, :content => "#{@book1.title}")
  		response.should have_selector( "div#author", :content =>	"#{@book1.author}")
  		response.should have_selector( :p, 	:content => "#{@book1.summary}")
  	end
  	
		describe "when not signed in" do
			
  		it "should not have add or delete button" do
  			response.should_not have_selector("div#favorite_form_1")
  		end
  		
  		it "link to fan profiles shouldn't work, if not signed in" do
  			click_link "#{@user1.username}"
  			response.should have_selector( :div, :content => "sign in or sign up")
  		end
  	
  	end
  	
  	describe "when signed in" do
  		
  		before(:each) do
  			visit signin_path
  			fill_in :email, 		:with => @user1.email
				fill_in :password, 	:with => @user1.password
				click_button
				visit book_path(@book1)
  		end
  		
  		it "should have add or delete button" do
  			response.should have_selector("div#favorite_form_1")
  		end
  		
  		it "link to user profile should work" do
	  		click_link "#{@user1.username}"
  			response.should have_selector( "div#user_profile")
  		end
  	end
  end
end
