module RecommendsHelper
	def new_display_header
		if @brand
	 		content_tag(:h1, "Recommend #{@brand.name}") +
	 		content_tag(:strong, "Category: #{@brand.category_name}")
 	  elsif @category
 		  content_tag(:h1, "#{@category.name} recommendation")
 	  else
 		 content_tag(:h1, "New recommendation!")
 	  end
	end
end
