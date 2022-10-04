# frozen_string_literal: true

class ImportDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    l created_at, format: :long
  end
end
