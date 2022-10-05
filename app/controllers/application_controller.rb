# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include Internationalization
  include LanguageDetection
  include TextFileImport
  include ZipFileImport

  after_action :set_route_info
  around_action :switch_locale

  def set_route_info
    session[:previous_url] = request.url
    session[:previous_controller] = prev_route[:controller]
    session[:previous_action] = prev_route[:action]
  end

  private

  def prev_route
    Rails.application.routes.recognize_path(URI(session[:previous_url]).path)
  end
end
