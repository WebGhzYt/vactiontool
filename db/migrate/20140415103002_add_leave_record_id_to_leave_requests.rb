class AddLeaveRecordIdToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :leave_record_id, :integer
  end
end
