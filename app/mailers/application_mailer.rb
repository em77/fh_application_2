class ApplicationMailer < ActionMailer::Base
  default from: "apply@#{Rails.application.credentials.sendgrid[:from_domain_name]}.org"
  layout 'mailer'
end
