class NoteDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_kindle_at
    off_set = Time.now.gmt_offset
    time_zone = ActiveSupport::TimeZone[off_set]
    created_kindle_at.in_time_zone(time_zone)
                     .strftime('%d.%m.%Y %H:%M:%S')
  end
end
