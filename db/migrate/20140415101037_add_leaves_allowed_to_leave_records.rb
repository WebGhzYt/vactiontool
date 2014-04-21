class AddLeavesAllowedToLeaveRecords < ActiveRecord::Migration
  def change
    add_column :leave_records, :leave_type, :integer
    add_column :leave_records, :leaves_allowed, :integer
  end
end
