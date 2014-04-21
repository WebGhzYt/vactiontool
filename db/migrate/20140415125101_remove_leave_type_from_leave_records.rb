class RemoveLeaveTypeFromLeaveRecords < ActiveRecord::Migration
  def change
    remove_column :leave_records, :leave_type, :integer
  end
end
