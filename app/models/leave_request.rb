class LeaveRequest < ActiveRecord::Base
  	

	belongs_to :user
	belongs_to :leave_type


	#validates :applied_date, presence: true
	validates :leave_type, presence: true
	validates :reason, presence: true
	validates :leaves_from, presence: true
	validates :leaves_to, presence: true
	#validates :status, presence: true
	#validates :status_date, presence: true, length: { maximum: 50 }
	validate :leave_request

	def leave_request
		
		# leave_type = self.leave_type
		leaves_to = self.leaves_to
		leaves_from = self.leaves_from
		applied_date = self.applied_date
		user_id = self.user_id
		@current_user = User.find_by(@user_id)
		# sl_allowed = @current_user.sl_allowed
		# cl_allowed = @current_user.cl_allowed
		# pl_allowed = @current_user.pl_allowed
		
		unless leaves_from.nil? && leaves_to.nil?

			leave_days = (leaves_to.to_date - leaves_from.to_date).to_i + 1 
			self.leave_days = leave_days
		
			leave_applied_gap = (leaves_from.to_date - applied_date.to_date).to_i

			if leaves_from.to_date > leaves_to.to_date 
				errors.add(:base, "Invalid date as leave_from must be before leaves_to !!")
			end

			if applied_date.to_date > leaves_from.to_date
				errors.add(:base, "Invalid date request!")
			end

			# @record = LeaveRecord.find_by(@user_id)
			# if @record
			# 	remaining_leaves = 24 - @record.leaves_taken

			# 	if remaining_leaves < leave_days
   #        			errors.add(:base, "Not permitted as you are left with less remaining leaves.") 
   #      		end
   #      	end
		end

# 		i = 0
# 		j = 0
# 		k = 0
# 		# all_leaves = current_user.leave_requests.map { |e| e.leave_type  }.inspect
# 		planned_leaves = LeaveRequest.where(:user_id => user_id)
# 		planned_leaves.each do |p|
# 			if p.leave_type == 'PL'
# 				i = i + p.leave_days
# 			elsif p.leave_type == 'CL'
# 				j = j + p.leave_days
# 			elsif p.leave_type == 'SL'
# 				k = k + p.leave_days
# 			end
# 		end
# 			logger.debug i
# 			logger.debug j
# 			logger.debug k

# 		# j = 0
# 		# # all_leaves = current_user.leave_requests.map { |e| e.leave_type  }.inspect
# 		# planned_leaves = LeaveRequest.where(:user_id => user_id)
# 		# planned_leaves.each do |p|
# 		# 	if p.leave_type == 'PL'
# 		# 		i = i + 1
# 		# 	end
# 		# 	logger.debug i
# 		# end

# 		# k = 0
# 		# # all_leaves = current_user.leave_requests.map { |e| e.leave_type  }.inspect
# 		# planned_leaves = LeaveRequest.where(:user_id => user_id)
# 		# planned_leaves.each do |p|
# 		# 	if p.leave_type == 'PL'
# 		# 		i = i + 1
# 		# 	end
# 		# 	logger.debug i
# 		# end
		
# 		#planned_leaves = current_user.where(:leave_type => 'PL')
# 		# pl_leaves = planned_leaves.count	

# 		# casual_leaves = LeaveRequest.where(:leave_type => 'CL')
# 		# cl_leaves = casual_leaves.count

# 		# sick_leaves = LeaveRequest.where(:leave_type => 'SL')
# 		# sl_leaves = sick_leaves.count
		
# 		# if leaves_from.to_date > leaves_to.to_date 
# 		# 	errors.add(:base, "Invalid date as leave_from must be before leaves_to !!")
# 		# end

# 		# if applied_date.to_date > leaves_from.to_date
# 		# 	errors.add(:base, "Invalid date request!")
# 		# end

# 		if leave_type == 'PL' && pl_allowed
# 			if i > pl_allowed
# 				errors.add(:base, "Sorry not granted, as you already accessed all your planned leaves!")
# 			end
# 			unless leaves_from.nil? && leaves_to.nil?
# 				if leave_applied_gap < 14
# 					errors.add(:base, "Sorry not granted, as you should inform 2 weeks earlier!")
# 				end
# 			end		
# 		end

		
# 		if leave_type == 'CL' && cl_allowed
# 		 	if j > cl_allowed
# 		 		errors.add(:base, "Sorry not granted, as you already accessed all your casual leaves!")
#   			elsif leave_days > 1
#   				errors.add(:base, "Sorry not granted, as only one casual leave can be granted at a time!")
#    			end
#   		end

#   		if leave_type == 'SL' && sl_allowed
# 			if k > sl_allowed
# 				errors.add(:base, "Sorry not granted, as you already accessed all your sick leaves!")
# 			end
# 		end
     
#         # if remaining_leaves < leave_days
#         #   errors.add(:base, "If you cross deadline of 24 leaves it will be Unpaid plz aware") 
#         # end
    end
 end
