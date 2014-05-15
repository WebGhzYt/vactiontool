class AddAvtarToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :avtar, :string
  end
end
