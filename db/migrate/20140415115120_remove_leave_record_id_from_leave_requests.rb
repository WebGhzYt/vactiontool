class RemoveLeaveRecordIdFromLeaveRequests < ActiveRecord::Migration
  def change
    remove_column :leave_requests, :leave_record_id, :integer
  end
end
