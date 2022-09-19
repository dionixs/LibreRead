# frozen_string_literal: true

module FileImport
  extend ActiveSupport::Concern

  included do
    private

    def text_file?(file)
      !file.nil? && File.extname(file.to_io) == '.txt'
    end

    def not_text_file(text_file)
      return flash[:warning] = 'You have not selected a file' if text_file.nil?

      flash[:warning] = 'Must be a txt file' unless text_file?(text_file)
    end

    def not_kindle_clipping_file(notes)
      flash[:warning] = 'Not a Kindle clipping file!' if notes.nil?
    end

    def import_failed?(text_file, notes)
      not_text_file(text_file) || not_kindle_clipping_file(notes)
    end

    def new_import_text_file(file)
      Import.new(
        filename: file.original_filename,
        mime_type: file.content_type,
        data: File.read(file.to_io)
      )
    end

    # todo
    def import_notes(import)
      ClippingsParser.new(import.data).notes
    end
  end
end
