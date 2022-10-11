# frozen_string_literal: true

class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :notes, through: :taggings

  validates :title, presence: true
end
