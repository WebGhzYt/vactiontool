class UsersController < ApplicationController
    def index
      @emp = current_user.users
    end

    def users_sign_in
    end
end
