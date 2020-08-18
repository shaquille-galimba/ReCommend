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

	def new_display_recommend_form
		if @brand
			form_with_brand
		elsif @category
			form_with_category
		else
			clean_recommend_form
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

	def index_display_user_name(recommend)
		if !@user
			content_tag(:h2, class: "links") do
				link_to(recommend.user_name, user_recommends_path(recommend.user), class: "links")
			end
		end
	end

	def show_edit_and_delete_button(recommend)
		if recommend.user == current_user
			content_tag(:li) do
				link_to("Edit", edit_recommend_path(recommend))
			end +
			content_tag(:li) do
				link_to "Delete", recommend_path(recommend), method: :delete, data: {confirm: "Are you sure you want to delete this recommendation?"}
			end
		end
	end


	private

	def form_with_brand
		content_tag(:div, class: "form") do
			form_for([@brand, @recommend]) do |f|
				f.hidden_field(:brand_id) +
				content_tag(:div) do
					f.label(:comment) +
					f.text_area(:comment)
				end + tag("br") +
				content_tag(:div) do
					f.submit "Recommend", class: "btn button-blue"
				end
			end
		end
	end

	def form_with_category
		content_tag(:div, class: "form") do
			form_for([@category, @recommend]) do |f|
				f.fields_for(:brand) do |b|
					b.hidden_field(:category_id) +
					content_tag(:div) do
						b.label(:name, "Brand") +
						b.text_field(:name)
					end + tag("br")
				end +
				content_tag(:div) do
					f.label(:comment) +
					f.text_area(:comment)
				end + tag("br") +
				content_tag(:div) do
					f.submit "Recommend", class: "btn button-blue"
				end
			end
		end
	end

	def clean_recommend_form
		content_tag(:div, class: "form") do
			form_for @recommend do |f|
				f.fields_for(:brand) do |b|
					content_tag(:div) do
						b.fields_for(:category) do |c|
							c.label(:name, "Category") +
							c.text_field(:name)
						end
					end + tag("br") +
					content_tag(:div) do
						b.label(:name, "Brand") +
						b.text_field(:name)
					end + tag("br") +
					content_tag(:div) do
						f.label(:comment) +
						f.text_area(:comment)
					end + tag("br") +
					content_tag(:div) do
						f.submit "Recommend", class: "btn button-blue"
					end
				end
			end
		end
	end
end
