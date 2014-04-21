class AddLeaveTypeIdToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :leave_type_id, :integer
  end
end
