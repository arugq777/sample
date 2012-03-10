module ApplicationHelper
  def title

    if user_signed_in?
      base_title = "Pseudobibliophilia"
    else
      base_title = "Psuedobibliotheque"
    end

    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
#  def logo
#    @logo = image_tag( "logo.png", :alt => "Sample App Logo!", :class => "round" )
#  end
  
end
