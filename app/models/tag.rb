# frozen_string_literal: true

class Tag < ApplicationRecord
  belongs_to :user
  has_many :note_tags, dependent: :destroy
  has_many :notes, through: :note_tags

  validates :title, presence: true
end
