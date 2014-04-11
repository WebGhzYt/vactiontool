class LeaveRequest < ActiveRecord::Base
  	validate :leave_request

	belongs_to :user
	belongs_to :leave_record


	validates :applied_date, presence: true, length: { maximum: 50 }
	validates :leave_type, presence: true, length: { maximum: 50 }
	validates :reason, presence: true, length: { maximum: 350 }
	validates :leaves_from, presence: true, length: { maximum: 50 }
	validates :leaves_to, presence: true, length: { maximum: 50 }
	validates :status, presence: true, length: { maximum: 50 }
	#validates :status_date, presence: true, length: { maximum: 50 }

	def leave_request
		
		leave_type = self.leave_type
		leaves_to = self.leaves_to
		leaves_from = self.leaves_from
		applied_date = self.applied_date
		user_id = self.user_id
		@current_user = User.find_by(@user_id)
		sl_allowed = @current_user.sl_allowed
		cl_allowed = @current_user.cl_allowed
		pl_allowed = @current_user.pl_allowed
		

		leave_days = (leaves_to.to_date - leaves_from.to_date).to_i + 1 
		
		leave_applied_gap = (leaves_from.to_date - applied_date.to_date).to_i
		
		@record = LeaveRecord.find_by(@user_id)
		remaining_leaves = 24 - @record.leaves_taken
		

		planned_leaves = LeaveRequest.where(:leave_type => 'PL')
		pl_leaves = planned_leaves.count
		

		casual_leaves = LeaveRequest.where(:leave_type => 'CL')
		cl_leaves = casual_leaves.count

		sick_leaves = LeaveRequest.where(:leave_type => 'SL')
		sl_leaves = sick_leaves.count
		
		if leaves_from.to_date > leaves_to.to_date 
			errors.add(:base, "Invalid date as leave_from must be before leaves_to !!")
		end

		if leave_type == 'PL'
			if pl_allowed == pl_leaves
				errors.add(:base, "Sorry not granted, as you already accessed all your planned leaves!")
			elsif leave_applied_gap < 14
				errors.add(:base, "Sorry not granted, as you should inform 2 weeks earlier!")
			end		
		end

		
		 if leave_type == 'CL'
		 	if cl_allowed == cl_leaves
		 		errors.add(:base, "Sorry not granted, as you already accessed all your casual leaves!")
  			elsif leave_days > 1
  				errors.add(:base, "Sorry not granted, as only one casual leave can be granted at a time!")
   			end
  		end
     
        if remaining_leaves < leave_days
          errors.add(:base, "If you cross deadline of 24 leaves it will be Unpaid plz aware") 
       end
   end
end

