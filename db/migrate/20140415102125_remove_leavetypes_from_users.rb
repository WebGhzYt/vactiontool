class RemoveLeavetypesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :sl_allowed, :integer
    remove_column :users, :pl_allowed, :integer
    remove_column :users, :cl_allowed, :integer
  end
end
