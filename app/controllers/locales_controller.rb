# frozen_string_literal: true

class LocalesController < ApplicationController
  def change_locale
    locale = params[:locale]
    new_locale = params[:new_locale]
    I18n.locale = locale_supported?(new_locale) ? new_locale : new_locale = locale
    session[:locale] = I18n.locale
    redirect_to previous_url_with_new_locale(new_locale, locale)
  end

  private

  def previous_url_with_new_locale(new_locale, locale)
    url_fragments.map { |fragment| fragment == locale ? new_locale : fragment }.join('/')
  end

  def url_fragments
    session[:previous_url].split('/')
  end
end
