# frozen_string_literal: true

class NoteTag < ApplicationRecord
  belongs_to :note
  belongs_to :tag
end
