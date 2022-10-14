# frozen_string_literal: true

module Avatarable
  extend ActiveSupport::Concern

  included do
    private

    def set_gravatar_hash
      return if email.blank?

      hash = Digest::MD5.hexdigest(email.strip.downcase)
      self.gravatar_hash = hash
    end
  end
end
