class RemoveTotalLeavesFromLeaveRecords < ActiveRecord::Migration
  def change
    remove_column :leave_records, :total_leaves, :integer
  end
end
