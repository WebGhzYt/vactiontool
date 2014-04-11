
class LeaveRecord < ActiveRecord::Base
	belongs_to :user
	has_many :leave_requests
	#attr_accessible :user_id, :total_leaves, :leaves_taken

	validates :user_id, presence: true, length: { maximum: 50 }
	validates :total_leaves, presence: true, length: { maximum: 50 }
	validates :leaves_taken, presence: true, length: { maximum: 50 }
end 
   

