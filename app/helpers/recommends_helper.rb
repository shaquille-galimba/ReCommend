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

	def index_display_header
		if @user
			content_tag(:h1, "#{@user.username}") +
			content_tag(:div, class: "navbar mini") do
				content_tag(:ul) do
					content_tag(:li, class: "separate") do
						link_to 'Info', user_path(@user)
					end +
					content_tag(:div, class: "info right") do
						render partial: "shared/search", locals: {path:user_recommends_path(@user)}
					end
				end
			end
		else
			content_tag(:h1, "Welcome to Recommend!") +
			content_tag(:div, class: "navbar mini") do
				content_tag(:ul) do
					content_tag(:div, class: "info right") do
						render partial: "shared/search", locals: {path: recommends_path}
					end
				end
			end
		end
	end

end
