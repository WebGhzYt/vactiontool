class LeaveRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :leave_type
  

 
  def emp_details(user_id)
    LeaveRecord.where(:user_id => user_id)
  end
  
end 
   

