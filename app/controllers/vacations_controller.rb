class VacationsController < ApplicationController
  def new
         @vacation = LeaveRequest.new
  end

  def home
  end

  def create
  #vacation = Vacation.new (params[:vacation])
    #@vacation = LeaveRequest.new(leave_params)
    # if @vacation.leave_type != 'SL'
    #  if @vacation.save  
    #    flash[:success] = "Leaves form successfully Submit"
    #    redirect_to root_path 
    #   else  
    #     render 'new'
    #   end
    # else
    #   if @vacation.save
    #     flash[:warning] = "Sick leaves might be need documentation"
    #    redirect_to root_path
    #   end   
    # end
    @vacation = LeaveRequest.new(leave_params)
    @vacation.user_id = current_user.id
    @vacation.status = 'pending'
    @vacation.status_date = Time.now
    @vacation.applied_date = Time.now
    if @vacation.save
      if @vacation.leave_type_id == '1'
        flash[:alert] = "Successfully submitted , You might need provide Documentation in future if required!"
      else
        flash[:notice] = "Leave Request successfully submitted."
      end
      redirect_to vacations_home_path
    else
      render 'new'
    end
  end

  def index
    @vacations = LeaveRequest.all
  end   

 def show_emp
   @emp = User.where(:manager_id => current_user.id)
  end

 def leave_request
   #@emp_requests = User.where(:manager_id => current_user.id) && LeaveRequest.where(:status => 'pending')
   @emp_requests = User.where(:manager_id => current_user.id)
   #@emp_requests_id = @emp_requests.where(:status => 'pending')
   @emp_requests_id = LeaveRequest.where(:status => 'pending')

 end 

  private
  def leave_params
    params.require(:leave_request).permit(:leave_type_id, :reason, :leaves_from, :leaves_to)
  end
end
