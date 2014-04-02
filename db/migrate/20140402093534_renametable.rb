class Renametable < ActiveRecord::Migration
  def change
  	rename_table :emp_leaves, :emp_leave_records
  	rename_table :leaves_applieds, :leave_requests
  end
end
