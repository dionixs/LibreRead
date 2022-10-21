# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    include Internationalization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      locale_from_session
      flash[:danger] = t('flash.alert.not_authorized')
      redirect_to(request.referer || root_path)
    end
  end
end
