class OmniauthCallbacksController < Devise::OmniauthCallbacksController
 def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

     logger.debug env["omniauth.auth"]
    
    unless @user.nil?
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        leave_record = LeaveRecord.find_by_id(@user.id)
        if leave_record.nil?
          LeaveRecord.create(total_leaves: 24,
                             leaves_taken: 0,
                             user_id: @user.id
                            )
        end
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      flash[:notice] = "Please login"
      redirect_to root_url
    end
  end
end
