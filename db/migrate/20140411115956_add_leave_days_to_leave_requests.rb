class AddLeaveDaysToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :leave_days, :integer
  end
end
