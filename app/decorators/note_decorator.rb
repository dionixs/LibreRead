# frozen_string_literal: true

class NoteDecorator < ApplicationDecorator
  delegate_all
  decorates_association :user

  def formatted_created_kindle_at
    l created_kindle_at, format: :long
  end
end
