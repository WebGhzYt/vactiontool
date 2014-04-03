class CreateLeaveRequests < ActiveRecord::Migration
  def change
    create_table :leaves_applieds do |t|
      t.datetime :applied_date
      t.string :leave_type
      t.string :reason
      t.datetime :leaves_from
      t.datetime :leaves_to
      t.string :status
      t.datetime :status_date

      t.timestamps
    end
  end
end
