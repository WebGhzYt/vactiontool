# class VacationsController < ApplicationController
#   def new
#          @vacation = LeaveRequest.new
#   end

 
#   def create
#      @vacation = LeaveRequest.new(leave_params)
#       $leave_days = (@vacation.leaves_to.to_date - @vacation.leaves_from.to_date).to_i + 1 
       
#        logger.debug $leave_days
       
#        @record = LeaveRecord.find_by(@user_id)
#        $remaining_leaves = 24 - @record.leaves_taken
#        #logger.debug "hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiibyeeeee"
#        logger.debug $remaining_leaves
#        #logger.debug "hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiibyeeee"
#       if ($remaining_leaves > $leave_days) 
#         if @vacation.save 
#           flash[:success] = "Leaves form successfully Submit"
#           redirect_to root_path
#         else 
#          render 'new'
#         end
#       else
#        flash[:success] = "You Have less remaining leaves so leaves should be Unpaid"  
#        redirect_to root_path 
#      end
#   end

#  def index
#     @vacations = LeaveRequest.all
#   end   

#   private

#     def leave_params
#       params.require(:leave_request).permit(:applied_date, :leave_type, :reason, :leaves_from, :leaves_to, :status, :status_date, :user_id)
#     end

# end


class VacationsController < ApplicationController
  def new
         @vacation = LeaveRequest.new
  end

 def create
    @vacation = LeaveRequest.new(leave_params)
    #$leave_days = (@vacation.leaves_to.to_date - @vacation.leaves_from.to_date).to_i + 1 
    #@record = LeaveRecord.find_by(@user_id)
    #$remaining_leaves = 24 - @record.leaves_taken
    #if ($remaining_leaves > $leave_days)
      #if(@vacation.leave_type=='CL' && $leave_days<2 )
        #@record.leaves_taken = @record.leaves_taken + $leave_days
        #@record.save
        if @vacation.save  
          flash[:success] = "Leaves form successfully Submit"
          redirect_to root_path 
        else 
          render 'new'
        end
      # else
      #  flash[:success] = "You Cannot apply two concecutive CL"
      #  redirect_to root_path
      # end   
    # else
    #   flash[:success] = "You Have less remaining leaves so leaves should be Unpaid"  
    #   redirect_to root_path 
    # end
  end

 def index
    @vacations = LeaveRequest.all
  end   

  private

    def leave_params
      params.require(:leave_request).permit(:applied_date, :leave_type, :reason, :leaves_from, :leaves_to, :status, :status_date, :user_id)
    end
end
