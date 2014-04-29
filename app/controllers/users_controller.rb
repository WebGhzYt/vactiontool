class UsersController < ApplicationController
	def index
		@emp = User.where(:manager_id => current_user.id)
	end

	def users_sign_in
	end

	def show
    	@employee_record = User.find(params[:id])
  	end
  	
end
