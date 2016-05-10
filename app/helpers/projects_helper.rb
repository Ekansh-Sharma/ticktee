module ProjectsHelper
	def admin_only(&block)
		block.call if current_user.try(:admin?)
	end
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end
