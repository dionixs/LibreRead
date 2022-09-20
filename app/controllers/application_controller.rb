# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include LanguageDetection
  include FileImport
end
