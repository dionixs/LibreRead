# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization
    include Authentication
    include Internationalization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      locale_from_session
      flash[:danger] = authorization_message
      redirect_to(request.referer || root_path)
    end

    def authorization_message
      current_user.banned? ? t('flash.alert.you_are_banned') : t('flash.alert.not_authorized')
    end
  end
end
