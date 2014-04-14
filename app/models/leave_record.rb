
class LeaveRecord < ActiveRecord::Base
	belongs_to :user
	has_many :leave_requests
	#attr_accessible :user_id, :total_leaves, :leaves_taken

	validates :user_id, presence: true
	validates :total_leaves, presence: true
	validates :leaves_taken, presence: true
end 
   

