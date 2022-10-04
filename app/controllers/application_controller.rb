# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include LanguageDetection
  include TextFileImport
  include ZipFileImport

  around_action :switch_locale

  private

  def switch_locale(&)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale(locale, &)
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
