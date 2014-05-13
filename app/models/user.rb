class User < ActiveRecord::Base
  
  # validates :provider, presence: true, length: { maximum: 50 }
  # validates :uid, presence: true, length: { maximum: 50 }
  has_and_belongs_to_many :roles
  has_many :leave_requests
  belongs_to :manager, class_name: 'User'
  has_many :users, class_name: 'User', foreign_key: 'manager_id'
  has_many :leave_records

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  after_save :check_has_access

  def check_has_access
    if self.has_access == true
      leave_record = LeaveRecord.find_by(:user_id => self.id)
        #LeaveType.each do |leave_type|
        if leave_record.nil?
          leaves = [12,6,6]
          LeaveType.all.each_with_index do |leave_type, index|
            LeaveRecord.create(user_id: self.id,
                             leave_type_id: leave_type.id,
                             leaves_allowed: leaves[index],
                             leaves_taken: 0
                            )
          end
        end
    end
  end

  def employee_requests(current_user_id)
    User.where(:manager_id => current_user_id)
  end


  #attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :provider, :uid

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
  
     registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      elsif data["email"]#.include?('@ongraph.com') 
        user = User.create(name:    data["name"],
                           provider: access_token.provider,
                           email:    data["email"],
                           uid:      access_token.uid ,
                           password: Devise.friendly_token[0,20],
                           manager_id: 0  )   
      end
  end

  def sl_records
    self.leave_records.find_by(:leave_type_id => 1)
  end

  def cl_records
    self.leave_records.find_by(:leave_type_id => 2)
  end

  def pl_records
    self.leave_records.find_by(:leave_type_id => 3)
  end

  def sl_pending_requests
    pending_sl = self.leave_requests.where(:leave_type_id => 1, state: "pending")
    pending_sl_leaves = 0
    pending_sl.each do |pending_sl|
      pending_sl_leaves = pending_sl_leaves + pending_sl.leave_days
    end
    pending_sl_leaves
  end

  def sl_approved_requests
    approved_sl = self.leave_requests.where(:leave_type_id => 1, state: "approved")
    approved_sl_leaves = 0
    approved_sl.each do |approved_sl|
      approved_sl_leaves = approved_sl_leaves + approved_sl.leave_days
    end
    approved_sl_leaves
  end

  def sl_unapproved_requests
    unapproved_sl = self.leave_requests.where(:leave_type_id => 1, state: "unapproved")
    unapproved_sl_leaves = 0
    unapproved_sl.each do |unapproved_sl|
      unapproved_sl_leaves = unapproved_sl_leaves + unapproved_sl.leave_days
    end
    unapproved_sl_leaves
  end

  def cl_pending_requests
    pending_cl = self.leave_requests.where(:leave_type_id => 2, state: "pending")
    pending_cl_leaves = 0
    pending_cl.each do |pending_cl|
      pending_cl_leaves = pending_cl_leaves + pending_cl.leave_days
    end
    pending_cl_leaves
  end

  def cl_approved_requests
    approved_cl = self.leave_requests.where(:leave_type_id => 2, state: "approved")
    approved_cl_leaves = 0
    approved_cl.each do |approved_cl|
      approved_cl_leaves = approved_cl_leaves + approved_cl.leave_days
    end
    approved_cl_leaves
  end

  def cl_unapproved_requests
    unapproved_cl = self.leave_requests.where(:leave_type_id => 2, state: "unapproved")
    unapproved_cl_leaves = 0
    unapproved_cl.each do |unapproved_cl|
      unapproved_cl_leaves = unapproved_cl_leaves + unapproved_cl.leave_days
    end
    unapproved_cl_leaves
  end

  def pl_pending_requests
    pending_pl = self.leave_requests.where(:leave_type_id => 3, state: "pending")
    pending_pl_leaves = 0
    pending_pl.each do |pending_pl|
      pending_pl_leaves = pending_pl_leaves + pending_pl.leave_days
    end
    pending_pl_leaves
  end

  def pl_approved_requests
    approved_pl = self.leave_requests.where(:leave_type_id => 3, state: "approved")
    approved_pl_leaves = 0
    approved_pl.each do |approved_pl|
      approved_pl_leaves = approved_pl_leaves + approved_pl.leave_days
    end
    approved_pl_leaves
  end

  def pl_unapproved_requests
    unapproved_pl = self.leave_requests.where(:leave_type_id => 3, state: "unapproved")
    unapproved_pl_leaves = 0
    unapproved_pl.each do |unapproved_pl|
      unapproved_pl_leaves = unapproved_pl_leaves + unapproved_pl.leave_days
    end
    unapproved_pl_leaves
  end

  def all_requests(employee)
      self.leave_requests.where(user_id: employee.id ,state: 'pending')
  end

end 
