class LeaveRecord < ActiveRecord::Base
	belongs_to :user
	belongs_to :leave_type
	has_many :users

	#attr_accessible :user_id, :total_leaves, :leaves_taken

	# validates :user_id, presence: true
	# validates :total_leaves, presence: true
	# validates :leaves_taken, presence: true
end 
   

