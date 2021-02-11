class SessionController < ApplicationController

	before_action :check_user_login_not, only:[:view_login_page,:view_signup_page]

	def view_login_page
		render 'session/login'
	end	

	def view_signup_page
		render 'session/signup'
	end
	
	def create_user
		@user_data = User.new(name: params[:name], email: params[:email], password: params[:password])	
		
		if @user_data.save
			session[:user_id] = @user_data.id
			
			respond_to do |f|
				flash[:success] = "Signup Successfully"
				f.html { redirect_to root_path}
			end
		else
		 render :json => {:status =>false, :errors => @user_data.errors.full_messages}
		end
	end

	def check_user_credentials

		@user_data = User.where(name: params[:email]).or(User.where(email: params[:email].downcase)).first
		
		# @user_data = User.find_by(email: params[:email])
		# if @user_data == nil
		# 	@user_data = User.find_by(name: params[:email])
		# end	
		
		if @user_data && @user_data.authenticate(params[:password])		

			session[:user_id] = @user_data.id
		 	respond_to do |f|			
				f.html { redirect_to root_path}
			end
		else
			render :json => {:status => false}
		end
	end

	def logout_user
		session[:user_id] = nil
		redirect_to root_path
	end
end