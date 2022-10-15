# frozen_string_literal: true

module ErrorHandling
  extend ActiveSupport::Concern

  # TODO
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found(exception)
      logger.warn(exception)
      render file: 'public/404.html', status: :not_found, layout: true
    end
  end
end
