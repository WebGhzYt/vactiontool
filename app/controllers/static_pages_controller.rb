class StaticPagesController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :check_access

  def home
  	
  end
end
