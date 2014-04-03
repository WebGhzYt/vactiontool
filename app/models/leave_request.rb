class LeaveRequest < ActiveRecord::Base
   

    #attr_accessible :applied_date, :leave_type, :reason, :leaves_from, :leaves_to, :status, :status_date

	validates :applied_date, presence: true, length: { maximum: 50 }
	validates :leave_type, presence: true, length: { maximum: 50 }
	validates :reason, presence: true, length: { maximum: 50 }
	validates :leaves_from, presence: true, length: { maximum: 50 }
	validates :leaves_to, presence: true, length: { maximum: 50 }
	validates :status, presence: true, length: { maximum: 50 }
	validates :status_date, presence: true, length: { maximum: 50 }
	
end
