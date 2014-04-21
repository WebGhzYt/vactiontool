class AddLeaveTypeIdToLeaveRecords < ActiveRecord::Migration
  def change
    add_column :leave_records, :leave_type_id, :integer
  end
end
