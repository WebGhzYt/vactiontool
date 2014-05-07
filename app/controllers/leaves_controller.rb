class LeavesController < ApplicationController
	def new
		@leave = LeaveRequest.new		
	end

	def create
		  @leave = LeaveRequest.new(leave_params)
    	@leave.user_id = current_user.id
    	#@leave.status = 'pending'
    	@leave.status_date = Time.now
    	@leave.applied_date = Time.now

    	if @leave.save
          EmployeeMailer.leave_request(@leave).deliver
          # format.html { redirect_to(@leave, notice: 'Leave Request was successfully created.') }
          # format.json { render json: @leave, status: :created, location: @user }
      		if @leave.leave_type.leave_type == 'SL'
        		flash[:alert] = "Successfully submitted , You might need provide Documentation in future if required!"
      		else
        		flash[:notice] = "Leave Request successfully submitted."
      		end
          # EmployeeMailer.welcome_user(@leave).deliver
          # format.html { redirect_to(@user, notice: 'Leave Request was successfully created.') }
          # format.json { render json: @user, status: :created, location: @user }
          logger.debug "7777777777777777777777777"
          logger.debug @leave.user.manager.name
          logger.debug @leave.user.manager.email
      		redirect_to root_path
    	else
          # format.html { render action: 'new' }
          # format.json { render json: @user.errors, status: :unprocessable_entity }
      		render 'new'
    	end

	end

	def requests
		@emp = User.where(:manager_id => current_user.id)
	end

  def approve_leave
    @app_leave = LeaveRequest.find(params[:id])
    @app_leave.approve
    
    EmployeeMailer.leave_approve_confirmation(@app_leave).deliver
    redirect_to leaves_requests_path    
  end

  def unapprove_leave
    @unapp_leave = LeaveRequest.find(params[:id])
    @unapp_leave.unapprove
    
    EmployeeMailer.leave_unapprove_confirmation(@unapp_leave).deliver
    redirect_to leaves_requests_path
  end

	private
  		def leave_params
    		params.require(:leave_request).permit(:leave_type_id, :reason, :leaves_from, :leaves_to)
  		end
end
