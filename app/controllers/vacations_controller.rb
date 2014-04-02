class VacationsController < ApplicationController
  def new
         @vacation = LeaveRequest.new
  end

 def create
  	 @vacation = LeaveRequest.new(leave_request_params)
  	 if @vacation.save 
  		 flash[:success] = "successfully save"
       redirect_to root_path
  	  else 
  	     render 'new'
  	  end
  end

 def index
    @vacations = LeaveRequest.all
  end   

  private

    def leave_request_params
      params.require(:leave_request).permit(:applied_date, :leave_type, :reason, :leaves_from, :leaves_to, :status, :status_date)
    end

end
