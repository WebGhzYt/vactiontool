class RemoveLeavetypeFromLeaveRequests < ActiveRecord::Migration
  def change
    remove_column :leave_requests, :leave_type, :string
  end
end
