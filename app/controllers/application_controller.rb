class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?
	
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def check_user_login_not
		if logged_in?
			flash[:error] = "You can not access this page"
			redirect_to root_path
		end
	end
end
