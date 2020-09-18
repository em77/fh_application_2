class MemberApplicationMailer < ApplicationMailer
  def new_member_application(member_application)
    @member_application = member_application

    mail to: Rails.application.credentials.dig(:member_application, member_application.bronx_or_manhattan.downcase.to_sym),
         subject: "New member application from #{member_application.first_name} #{member_application.last_name}"
  end
end
