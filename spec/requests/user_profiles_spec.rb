require 'spec_helper'

describe "UserProfiles" do
  
  before(:each) do
    @book1 = FactoryGirl.create(:book)
    @book2 = FactoryGirl.create(:book, :title => "book2")
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, :username => "user2",
                            :email     => "user2@example.com")
    @user1.favorited_books.create( :favorited_id => @book1.id )
    @user2.favorited_books.create( :favorited_id => @book2.id )
  end
  describe "GET /users" do
    
    before(:each) do
      get "/users"
    end
    
    it "should list users" do
      response.should have_selector("td.user a", :content => "#{@user1.username}")
      response.should have_selector("td.user a", :content => "#{@user2.username}")
    end
    
    it "should list number of favorites" do
      response.should have_selector("td.stats", :content => "#{@user1.favorites.count}")
    end
  end
  
  describe "user profiles" do
 
     before(:each) do
      visit signin_path
      fill_in :email, :with => @user1.email
      fill_in :password, :with => @user1.password
      click_button
      visit user_path(@user2)
    end
    it "should list favorites" do
      response.should contain("#{@book2.title}")
      response.should contain("#{@book2.author}")
    end
    it "should count favorites" do
      response.should contain("Favorites: 1")
    end
    it "should display username, name and url" do
      response.should contain("#{@user2.username}")
      response.should contain("#{@user2.name}")
      response.should contain("users/#{@user2.id}")
    end
  end
end
