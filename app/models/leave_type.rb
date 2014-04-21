class LeaveType < ActiveRecord::Base
	has_many :leave_requests
	has_many :leave_records
end
