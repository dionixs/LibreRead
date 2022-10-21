# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Turbo::Redirection
  include Pagy::Backend
  include ErrorHandling
  include Authentication
  include Authorization
  include Internationalization
  include LanguageDetection
  include RouteHandling
  include TextFileImport
  include NoteHandling
  include ZipFileImport
end
