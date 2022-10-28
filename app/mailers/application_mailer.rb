# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@libreread.com'
  layout 'mailer'
end
