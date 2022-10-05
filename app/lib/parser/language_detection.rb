# frozen_string_literal: true

module Parser
  module LanguageDetection
    def eng_lang?(obj)
      detect_lang(obj) == 'en'
    end

    def ru_lang?(obj)
      detect_lang(obj) == 'ru'
    end

    def detect_lang(obj)
      CLD.detect_language(obj)[:code]
    end
  end
end
