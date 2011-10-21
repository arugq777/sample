module ApplicationHelper
  def title
    base_title = "Library"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
#	def logo
#    @logo = image_tag( "logo.png", :alt => "Sample App Logo!", :class => "round" )
#	end
  
end
