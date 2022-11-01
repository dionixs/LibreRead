# frozen_string_literal: true

module Digestible
  extend ActiveSupport::Concern

  included do
    private

    def digest(string)
      cost = if ActiveModel::SecurePassword
                .min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end
  end
end
