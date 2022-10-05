# frozen_string_literal: true

module Internationalization
  extend ActiveSupport::Concern

  included do
    private

    def switch_locale(&)
      I18n.locale = locale_from_url || session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
      I18n.with_locale(I18n.locale, &)
    end

    def locale_from_url
      locale = params[:locale]
      locale if locale_supported?(locale)
    end

    def locale_supported?(locale)
      I18n.available_locales.map(&:to_s).include?(locale)
    end

    def default_url_options
      { locale: I18n.locale }
    end
  end
end
