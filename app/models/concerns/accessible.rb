# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern

  included do
    def author?(obj)
      obj.user == self
    end

    def owner?(obj)
      self == obj
    end

    def guest?
      false
    end
  end
end
