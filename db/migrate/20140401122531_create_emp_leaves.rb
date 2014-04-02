class CreateEmpLeaveRecord < ActiveRecord::Migration
  def change
    create_table :emp_leaves do |t|
      t.integer :user_id
      t.integer :total_leaves
      t.integer :leaves_taken
      t.string :status
      t.integer :worked_on_off_days

      t.timestamps
    end
  end
end
