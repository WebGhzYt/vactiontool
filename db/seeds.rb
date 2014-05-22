# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 ActiveRecord::Base.connection.execute("TRUNCATE roles")
 ActiveRecord::Base.connection.reset_pk_sequence!('roles')

  roles = ['Admin','Manager','Employee', 'HR']

  roles.each do |index|
     role = Role.new(:role_name => index)
     role.save!
  end

  ActiveRecord::Base.connection.execute("TRUNCATE leave_types")
 ActiveRecord::Base.connection.reset_pk_sequence!('leave_types')

  leave_types = ['SL','CL','PL']

  leave_types.each do |index|
     leave_type = LeaveType.new(:leave_type => index)
     leave_type.save!
  end