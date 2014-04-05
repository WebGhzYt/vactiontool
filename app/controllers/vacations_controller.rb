class VacationsController < ApplicationController
  def new
         @vacation = LeaveRequest.new
  end

 def create
    @vacation = LeaveRequest.new(leave_params)
    if @vacation.leave_type != 'SL'
     if @vacation.save  
       flash[:success] = "Leaves form successfully Submit"
       redirect_to root_path 
      else 
        render 'new'
      end
    else
      if @vacation.save
        flash[:warning] = "Sick leaves might be need documentation"
       redirect_to root_path 
      end   
    end
  end

 def index
    @vacations = LeaveRequest.all
  end   

  private

    def leave_params
      params.require(:leave_request).permit(:applied_date, :leave_type, :reason, :leaves_from, :leaves_to, :status, :status_date, :user_id)
    end
end
