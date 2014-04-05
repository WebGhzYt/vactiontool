class AddUserIdToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :user_id, :integer
  end
end
