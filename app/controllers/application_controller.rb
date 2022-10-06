# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include Internationalization
  include LanguageDetection
  include RoutesHandling
  include TextFileImport
  include ZipFileImport
end
