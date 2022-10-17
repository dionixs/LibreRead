# frozen_string_literal: true

module TextFileImport
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    include LanguageDetection

    private

    def text_file?(file)
      !file.nil? && File.extname(file.to_io) == '.txt'
    end

    def not_text_file(text_file)
      return flash[:alert] = t('flash.alert.not_selected_file') if text_file.nil?

      flash[:alert] = t('flash.alert.is_not_txt_file') unless text_file?(text_file)
    end

    def not_kindle_clipping_file(notes)
      flash[:alert] = t('flash.alert.not_kindle_clipping_file') if notes.nil?
    end

    def lang_not_supported(text_file)
      flash[:alert] = t('flash.alert.lang_not_supported') if lang_not_support?(text_file.read)
    end

    def no_new_highlights(notes)
      flash[:alert] = t('flash.alert.no_new_highlights') if notes.blank?
    end

    def import_failed?(text_file, notes)
      not_text_file(text_file) || lang_not_supported(text_file) ||
        not_kindle_clipping_file(notes) || no_new_highlights(notes)
    end

    def new_import(file)
      current_user.imports.build(
        filename: file.original_filename,
        mime_type: file.content_type,
        data: File.read(file.to_io)
      )
    end

    def extract_notes(data)
      parser = ClippingsParser.new(data)
      parser.extract_notes
    end
  end
  # rubocop:enable Metrics/BlockLength
end
