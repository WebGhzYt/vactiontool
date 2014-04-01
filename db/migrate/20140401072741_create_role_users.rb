class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users do |t|
      t.integer :roleId
      t.integer :userId

      t.timestamps
    end
  end
end
