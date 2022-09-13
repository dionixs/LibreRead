# frozen_string_literal: true

class Import < ApplicationRecord
  has_many :notes, dependent: :destroy

  validates :filename, presence: true, length: { in: 1..200 }
  validates :mime_type, presence: true
  validates :data, presence: true
end
