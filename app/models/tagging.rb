# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :note
  belongs_to :tag
end
