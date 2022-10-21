# frozen_string_literal: true

class Tag < ApplicationRecord
  include Authorship

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :notes, through: :taggings

  validates :title, presence: true
end
