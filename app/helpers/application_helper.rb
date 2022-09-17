module ApplicationHelper
  include Pagy::Frontend

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
