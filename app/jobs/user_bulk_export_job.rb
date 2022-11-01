# frozen_string_literal: true

class UserBulkExportJob < ApplicationJob
  queue_as :default

  def perform(initiator)
    stream = UserBulkExportService.call
  rescue StandardError => e
    Admin::UserMailer.with(user: initiator, error: e)
                     .bulk_export_fail.deliver_now
  else
    Admin::UserMailer.with(user: initiator, stream:)
                     .bulk_export_done.deliver_now
  end
end
