require 'spec_helper'

describe "Layouts" do
  describe"GET Home" do
    it "should retrieve the front page" do
      get '/home'
      response.status.should be(200)
      response.should have_selector(:title, :content => "Home")
    end
    
    it "should also be the root_path" do
      get '/'
       response.status.should be(200)
      response.should have_selector(:title, :content => "Home")
    end

    it "should have 'Pseudobibliotheque' in big ol' letters" do
      get '/'
      response.should have_selector(:h1, :content => "Pseudobibliotheque")
    end
    
    it "should have sign in and sign up links in the body" do
      get '/'
       response.should have_selector( 'div#main' ) do |main|
         main.should have_selector( 'p a', :content => "sign in") do
           click_link "sign in"
             response.should have_selector( :h2, :content => "Sign in")
         end
         main.should have_selector( 'p a', :content => "sign up") do
           click_link "sign up"
             response.should have_selector( :h2, :content => "Sign up" )
         end
       end
    end
  end
#  it "'Home' should have sign up link in the body" do
#    get '/'
#    response.should have_selector( 'div#main', :content => "Sign Up")
#  end
  describe "GET About" do
     it "should have an 'About' page at '/about'" do
      get '/about'
      response.status.should be(200)
      response.should have_selector( :h1, :content => "About" )
    end
    
    it "should have the right title, too" do
      get '/about'
      response.should have_selector( :title, :content => "About" )
    end
  end
  
  describe "GET books" do
    it "should get books page" do
      get "/books"
      response.should have_selector( :h2, :content => "The Catalogue")
    end
    it "should have the correct title, too" do
      get "/books"
      response.should have_selector( :title, :content => "All Books")
    end
  end
  
  describe "GET users" do
    it "should get users page" do
      get "/users"
      response.should have_selector( :h2, :content => "Readers")
    end
    it "should have the correct title, too" do
      get "/users"
      response.should have_selector(:title, :content => "All Users")
    end
  end
  
  describe "GET Sign In" do
    it "should get the sign in page" do
      get '/signin'
      response.status.should be(200)
      response.should have_selector( :h2, :content => "Sign in")
      
      # I should probably figure out how to change the titles of 
      # the Devise pages. Helper module, I guess?
    end
  end

  describe "GET Sign Up" do
    it "should get the sign up page" do
      get '/signup'
      response.should have_selector( :h2, :content => "Sign up")
    end
  end
  
  describe "Clicking all the links in the header" do
    it "should go to all the right pages" do
      visit root_path
      click_link "About"
        response.should have_selector( :title, :content => "About" )
      click_link "Books"
        response.should have_selector( :title, :content => "Books" )
      click_link "Users"
        response.should have_selector( :title, :content => "Users" )
      click_link "Home"
        response.should have_selector( :title, :content => "Home" )
      click_link "Sign In"
        response.should have_selector( :h2, :content => "Sign in" )
      click_link "Sign Up"
        response.should have_selector( :h2, :content => "Sign up" )
    end
  end
  
  describe "when signed in" do

    before(:each) do
      @user=FactoryGirl.create(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should say 'Pseudobibliophilia' in big ol' letters" do
      get "/"
      response.should have_selector(:h1, :content => "Pseudobibliophilia")
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector(
        "a", :href => signout_path, :content => "Sign Out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector(
        "a",  :href => user_path(@user), 
        :content => "#{@user.username}")
    end
    
    it "should logout with 'Sign Out' link" do
      visit root_path
      click_link "Sign Out"
        response.should have_selector( 
          "div#messages", :content => "Signed out")
        response.should have_selector(
          :title, :content=>"Home")
    end
  end
end