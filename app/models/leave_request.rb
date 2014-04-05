class LeaveRequest < ActiveRecord::Base
  	validate :leave_request

	belongs_to :user
	belongs_to :leave_record


	validates :applied_date, presence: true, length: { maximum: 50 }
	validates :leave_type, presence: true, length: { maximum: 50 }
	validates :reason, presence: true, length: { maximum: 50 }
	validates :leaves_from, presence: true, length: { maximum: 50 }
	validates :leaves_to, presence: true, length: { maximum: 50 }
	validates :status, presence: true, length: { maximum: 50 }
	#validates :status_date, presence: true, length: { maximum: 50 }

	def leave_request
		leave_type = self.leave_type
		leaves_to = self.leaves_to
		leaves_from = self.leaves_from
		applied_date = self.applied_date

		leave_days = (leaves_to.to_date - leaves_from.to_date).to_i + 1 
		logger.debug leave_days

		leave_applied_gap = (leaves_from.to_date - applied_date.to_date).to_i
		logger.debug leave_applied_gap


		@record = LeaveRecord.find_by(@user_id)
		remaining_leaves = 24 - @record.leaves_taken
		logger.debug remaining_leaves

		if leave_type == 'PL' && leave_applied_gap < 14
			errors.add(:base, "Sorry not granted, as you should inform earlier!")
			logger.debug "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
			logger.debug leave_type
			logger.debug leave_days
		end
		#if 
	end

	
end

