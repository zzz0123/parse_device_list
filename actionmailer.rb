require 'action_mailer'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address:   'smtp.gmail.com',
    port:      587,
    domain:    'smtp.gmail.com',
    user_name: ($stderr.print 'SMTP username> '; gets.chomp),
    password:  ($stderr.print 'SMTP password> '; gets.chomp)
}

class SampleMailer < ActionMailer::Base
  def first_example(body)
    mail(
      to:      'sample@example.com',
      from:    'sample@example.com',
      subject: 'Mail from SampleMailer',
      body:    body.to_s
    )
  end
end
