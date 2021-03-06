require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Pseudobibliotheque"
  end

  describe "GET 'home'" do

    it "should be successful" do
      get :home
      response.should be_success
    end
    
    it "should have a 'Home' title" do
      get :home
      response.should have_selector( "title", :content => @base_title + " | Home" )
    end
  end
end
