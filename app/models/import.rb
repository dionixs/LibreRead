# frozen_string_literal: true

class Import < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :delete_all

  validates :filename, presence: true, length: { in: 1..200 }
  validates :mime_type, presence: true
  validates :data, presence: true
end
