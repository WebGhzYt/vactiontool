class AddLeavetypesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sl_allowed, :integer
    add_column :users, :pl_allowed, :integer
    add_column :users, :cl_allowed, :integer
  end
end
