class Note < ApplicationRecord
  belongs_to :import

  validates :title, presence: true
  validates :author, presence: true
  validates :place, presence: true
  validates :created_kindle_at, presence: true
  validates :clipping, presence: true
end
