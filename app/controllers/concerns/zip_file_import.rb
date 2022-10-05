# frozen_string_literal: true

module ZipFileImport
  extend ActiveSupport::Concern

  included do
    private

    def not_zip_file(file)
      return flash[:alert] = t('flash.alert.is_not_zip_file') unless valid_zip?(file)
    end

    def valid_zip?(file)
      zip = Zip::File.open(file)
      true
    rescue StandardError
      false
    ensure
      zip&.close
    end
  end
end
