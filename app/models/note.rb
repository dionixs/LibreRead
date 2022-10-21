# frozen_string_literal: true

class Note < ApplicationRecord
  include Authorship
  include Taggable

  belongs_to :user
  belongs_to :import
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  before_destroy :delete_all_tags, prepend: true

  validates :title, presence: true, length: { minimum: 2 }
  validates :author, presence: true
  validates :place, presence: true
  validates :created_kindle_at, presence: true
  validates :clipping, presence: true
end
