class ApplicationMailer < ActionMailer::Base
  default from: "Fountain House <apply@#{Rails.application.credentials.sendgrid[:from_domain_name]}.org>"
  layout 'mailer'
end
