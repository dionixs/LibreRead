# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def pagination(obj)
    # rubocop:disable Rails/OutputSafety
    raw(pagy_nav(obj).html_safe) if obj.pages > 1
    # rubocop:enable Rails/OutputSafety
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'LibreRead'
    if page_title.empty?
      base_title
    else
      page_title.to_s
    end
  end
end
