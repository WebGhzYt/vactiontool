class User < ActiveRecord::Base
  
  # validates :provider, presence: true, length: { maximum: 50 }
  # validates :uid, presence: true, length: { maximum: 50 }
  has_and_belongs_to_many :role
  
  belongs_to :manager, class_name: 'User'
  has_one :leave_record
  has_many :leave_requests

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  #attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :provider, :uid

 def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
  
     registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      elsif data["email"].include?('@ongraph.com') 
        user = User.create(name:    data["name"],
                           provider: access_token.provider,
                           email:    data["email"],
                           uid:      access_token.uid ,
                           password: Devise.friendly_token[0,20],
                           manager_id: 0  )
        
        
    end
  end
end 

