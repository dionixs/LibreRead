# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :import
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags

  validates :title, presence: true
  validates :author, presence: true
  validates :place, presence: true
  validates :created_kindle_at, presence: true
  validates :clipping, presence: true
end
