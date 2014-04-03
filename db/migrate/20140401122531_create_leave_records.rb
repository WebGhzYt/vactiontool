class CreateLeaveRecords < ActiveRecord::Migration
  def change
    create_table :leave_records do |t|
      t.integer :user_id
      t.integer :total_leaves
      t.integer :leaves_taken

      t.timestamps
    end
  end
end
