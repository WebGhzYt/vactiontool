class User < ActiveRecord::Base
  
  # validates :provider, presence: true, length: { maximum: 50 }
  # validates :uid, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@ongraph.com/i
  # validates :email, presence:   true,
  #                   format:     { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :provider, :uid


  
  # METHODS ---------------------------------------------
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)


    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
       return user
     else
       registered_user = User.where(:email => access_token.info.email).first
       if registered_user
          return registered_user
        elsif data["email"].include?('@ongraph.com')
           user = User.create(
             provider:access_token.provider,
           email: data["email"],
           uid: access_token.uid ,
           password: Devise.friendly_token[0,20],
           )
        end
    end
 end
end 

