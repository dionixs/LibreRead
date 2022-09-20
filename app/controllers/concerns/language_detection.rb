# frozen_string_literal: true

module LanguageDetection
  extend ActiveSupport::Concern

  included do

    private

    def lang_support?(text)
      eng_lang?(text) || ru_lang?(text)
    end

    def lang_not_support?(text)
      !lang_support?(text)
    end

    def lang_detect(text)
      CLD.detect_language(text)[:code]
    end

    def ru_lang?(text)
      lang_detect(text) == 'ru'
    end

    def eng_lang?(text)
      lang_detect(text) == 'en'
    end
  end
end
