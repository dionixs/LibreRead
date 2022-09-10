module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'LibreRead'
    if page_title.empty?
      base_title
    else
      page_title.to_s
    end
  end

  # Returns local time
  def local_time(time)
    time.in_time_zone(time_zone)
        .strftime('%d.%m.%Y %H:%M:%S')
  end

  # Returns time zone
  def time_zone
    off_set = Time.now.gmt_offset
    ActiveSupport::TimeZone[off_set]
  end
end
