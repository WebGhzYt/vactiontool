class EmployeeMailer < ActionMailer::Base
  default from: "ongraph.mailer@gmail.com"

  def leave_request(leave_details)
  	@leave_details = leave_details
  	mail(to: @leave_details.user.manager.email, subject: "Leave Request from #{@leave_details.user.name}")
  end

  def leave_approve_confirmation(app_leave)
    @app_leave = app_leave
    emails = [@app_leave.user.email , @app_leave.user.manager.email]
    #emails.each_with_index do |send_email, index|
      mail(to: emails, subject: "Leave Approved")
    #end
    # mail(to: @app_leave.user.email, subject: "Leave Approved!")
    # mail(to: @app_leave.user.manager.email, subject: "Leave Granted!")
  end

  def leave_unapprove_confirmation(unapp_leave)
    @unapp_leave = unapp_leave
    emails = [@unapp_leave.user.email , @unapp_leave.user.manager.email]
    # emails.each_with_index do |send_email, index|
      mail(to: emails, subject: "Leave Unapproved")
    # end
    # mail(to: @unapp_leave.user.email,@unapp_leave.manager.email , subject: "Leave Approved!")
  end

end
