require 'spec_helper'

describe "User actions" do

  before(:each) do
    @user  = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, :email => "ex2@example.com", :username=> "ux2")
    @book  = FactoryGirl.create(:book)
    @book2 = FactoryGirl.create(:book)
    @user.favorited_books.create(:favorited_id => @book.id)
    @user2.favorited_books.create(:favorited_id => @book2.id)
  end

  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Username",             :with => ""
          fill_in "Your real name",       :with => ""
          fill_in "Email",                :with => ""
          fill_in "Password",             :with => ""
          fill_in "Password confirmation",:with => ""
          click_button
          response.should render_template("devise/registrations/new")
          response.should have_selector( "div#error_explanation" )
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Username",             :with => "example"
          fill_in "Your real name",       :with => "Example User"
          fill_in "Email",                :with => "example@example.com"
          fill_in "Password",             :with => "password"
          fill_in "Password confirmation",:with => "password"
          click_button
          response.should render_template("users/show")
          response.should have_selector(  "div", 
                                          :content => "Welcome!")
          response.should_not have_selector( "div#error_explanation" )
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div", :content => "Invalid")
      end
    end
    describe "success" do
      it "should sign a user in and out" do
        visit signin_path
        fill_in :email,    :with => @user.email
        fill_in :password, :with => @user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

  describe "when signed out" do
    it "should not allow viewing of profiles" do
      visit user_path(@user)
      response.should contain("sign in or sign up")
      response.should_not have_selector("#footer")
    end
  end

  describe "when signed in" do
    before(:each) do
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should forward to user's profile" do
      response.should contain("users/#{@user.id}")
    end
    
    it "should allow deleting books" do
#      click_button "Delete Favorite"
      @user.favorites.destroy(@book)
      @user.favorites.count.should == 0
    end
      
    it "should allow adding books" do
      @user.favorites.create(:favorited_id =>@book2)
      @user.favorites.count.should == 2
    end
      
    it "should have a footer" do
      response.should have_selector("#footer")
      response.should contain("Signed in as #{@user.name}")
      
    end
    describe "edit user" do
      it "should accept valid changes" do      
        click_link "Edit profile"
        fill_in "Username",             :with => "example"
        fill_in "Name",                 :with => "Example User"
        fill_in "Email",                :with => "example@example.com"
        fill_in "Password",             :with => "password1"
        fill_in "Password confirmation",:with => "password1"
        fill_in "Current password",     :with => "password"
        click_button
        response.should_not have_selector("div#error_explanation")
      end
      
      it "should reject junk" do
        click_link "Edit profile"
        fill_in "Username",             :with => ""
        fill_in "Name",                 :with => ""
        fill_in "Email",                :with => ""
        fill_in "Password",             :with => ""
        fill_in "Password confirmation",:with => ""
        fill_in "Current password",     :with => ""
        click_button
        response.should have_selector("div#error_explanation")        
      end
    end
  end 
end