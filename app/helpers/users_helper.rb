module UsersHelper
	def show_edit_info_and_delete_account_button
		if @user == current_user
			content_tag(:li) do
				link_to("Edit username", edit_user_path(@user))
			end +
			content_tag(:li) do
				link_to "Delete account", user_path(@user), method: :delete, data: {confirm: "Are you sure you want to delete your account?"}
			end
		end
	end
end
