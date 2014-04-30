class LeavesController < ApplicationController
	def new
		@leave = LeaveRequest.new		
	end

	def create
		@leave = LeaveRequest.new(leave_params)
    	@leave.user_id = current_user.id
    	@leave.status = 'pending'
    	@leave.status_date = Time.now
    	@leave.applied_date = Time.now
    	if @leave.save
      		if @leave.leave_type.leave_type == 'SL'
        		flash[:alert] = "Successfully submitted , You might need provide Documentation in future if required!"
      		else
        		flash[:notice] = "Leave Request successfully submitted."
      		end
      		redirect_to root_path
    	else
      		render 'new'
    	end
	end

	def requests
		@emp = User.where(:manager_id => current_user.id)
	end

  def approve_leave
    @app_leave = LeaveRequest.find(params[:id])
    @app_leave.approve
    redirect_to leaves_requests_path    
  end

  def unapprove_leave
    @unapp_leave = LeaveRequest.find(params[:id])
    @unapp_leave.unapprove
    redirect_to leaves_requests_path
  end

	private
  		def leave_params
    		params.require(:leave_request).permit(:leave_type_id, :reason, :leaves_from, :leaves_to)
  		end
end
