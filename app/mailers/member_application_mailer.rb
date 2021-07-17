class MemberApplicationMailer < ApplicationMailer
  def new_member_application(member_application)
    @member_application = member_application

    mail to: clubhouse_email,
         subject: "New member application from #{member_application.first_name} #{member_application.last_name}"
  end

  def edit_application_notification(member_application, rcpt)
    @member_application = member_application
    mail to: rcpt,
         subject: "Application started for #{member_application.first_name} #{member_application.last_name}"
  end

  def submitted_application_notification(member_application, rcpt)
    @member_application = member_application

    mail to: rcpt,
         subject: "Application submitted for #{member_application.first_name} #{member_application.last_name}"
  end

  private

  def clubhouse_email
    @member_application.save if @member_application.clubhouse.blank?
    @member_application.reload.clubhouse.email_address
  end
end
