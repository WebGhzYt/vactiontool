class StaticPagesController < ApplicationController
  	skip_before_filter :authenticate_user!
  	skip_before_filter :check_access

  	def home
  	
  	end

  	def holidays
  		@official_holidays = Holidays::IN.holidays_by_month
  	end
end
