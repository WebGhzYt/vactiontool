class AddStateToLeaveRequests < ActiveRecord::Migration
  def change
    add_column :leave_requests, :state, :string
  end
end
