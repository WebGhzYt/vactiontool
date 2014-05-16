class LeavesController < ApplicationController
	def new
		@leave = LeaveRequest.new		
	end

	def create
		  @leave = LeaveRequest.new(leave_params)
    	@leave.user_id = current_user.id
    	@leave.status_date = Time.now
    	@leave.applied_date = Time.now

    	if @leave.save
          EmployeeMailer.leave_request(@leave).deliver
          if $check
            flash[:notice] = "Saturday/Sunday and Official holidays are excluded from your leave request."
          end
          # format.html { redirect_to(@leave, notice: 'Leave Request was successfully created.') }
          # format.json { render json: @leave, status: :created, location: @user }
      		if @leave.leave_type.leave_type == 'SL' && ( @leave.avtar.nil? || @leave.avtar.blank? )
        		flash[:alert] = "Successfully submitted , You might need provide Documentation in future if required!"
      		else
        		flash[:success] = "Leave Request successfully submitted."
      		end
      		redirect_to root_path
    	else
          # format.html { render action: 'new' }
          # format.json { render json: @user.errors, status: :unprocessable_entity }
      		render 'new'
    	end
	end

	def requests
    emp_requests = User.new
		@emp = emp_requests.employee_requests(current_user.id)
	end

  def approve_leave
    leave_request = LeaveRequest.new
    @app_leave = leave_request.find_by_id(params[:id])
    @leave_record = LeaveRecord.find_by(user_id: @app_leave.user_id, leave_type_id: @app_leave.leave_type_id)

    @app_leave.approve
    
    @leaves_taken = @leave_record.leaves_taken + @app_leave.leave_days

    @leave_record.update_attribute(:leaves_taken , @leaves_taken)

    EmployeeMailer.leave_approve_confirmation(@app_leave).deliver
    redirect_to leaves_requests_path    
  end

  def unapprove_leave
    leave_request = LeaveRequest.new
    @unapp_leave = leave_request.find_by_id(params[:id])
    @unapp_leave.unapprove
    logger.debug @unapp_leave.inspect
    EmployeeMailer.leave_unapprove_confirmation(@unapp_leave).deliver
    redirect_to leaves_requests_path
  end

	private
  		def leave_params
    		params.require(:leave_request).permit(:leave_type_id, :reason, :leaves_from, :leaves_to, :avtar)
  		end
end
