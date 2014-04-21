class DropLeaveTypes < ActiveRecord::Migration
  def change
    drop_table :leave_types
  end
end
