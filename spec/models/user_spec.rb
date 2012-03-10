require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user2 = {
    :username => "mr_ex2",
    :name => "Ed Xavier",
    :email => "ex2@example.com",
    :password => "password",
    :password_confirmation => "password"
    }
  end
  it "should create a valid user" do
    User.create(@user2)
  end
  
  it "should require a username" do
    blank_username = User.new( @user2.merge( :username => "" ))
    blank_username.should_not be_valid
  end

  it "should reject long usernames" do
    long_username = User.new( @user2.merge( :username => "a"*29 ))
    long_username.should_not be_valid
  end

  it "should reject duplicate usernames" do
    dupe_username = User.new( @user2.merge( :username => "mr_ex" ))
    dupe_username.should_not be_valid    
  end
  
  it "should reject long names" do
    long_name = User.new( @user2.merge( :name => "a"*60 ))
    long_name.should_not be_valid
  end

  it "should require an email" do
    blank_email = User.new( @user2.merge( :email => "" ))
    blank_email.should_not be_valid
  end

  it "should reject duplicate emails" do
    dupe_email = User.new( @user2.merge( :email => "ex@example.com" ))
    dupe_email.should_not be_valid    
  end
  
  it "should reject identical emails with different capitilizations" do
    upcased_email = @user.email.upcase
    dupe_email = User.new( @user2.merge(:email => upcased_email) )
    dupe_email.should_not be_valid
  end
  
  describe "password validations" do
    it "should require a password" do
      User.new( @user2.merge( 
        :password => "", :password_confirmation => "") ).
      should_not be_valid
    end

    it "should have matching confirmation" do
      User.new( @user2.merge( :password_confirmation => "PASSW" ) ).
      should_not be_valid
    end

    it "should reject short passwords" do
      short_string = 'a' * 5
      with_short_password = @user2.merge( 
        :password => short_string, 
        :password_confirmation => short_string )
      User.new(with_short_password).should_not be_valid
    end

    it "should reject long passwords" do
      long_string = 'a' * 51
      with_long_password = @user2.merge( 
        :password => long_string, 
        :password_confirmation => long_string )
      User.new( with_long_password ).should_not be_valid
    end
  end
  
end
