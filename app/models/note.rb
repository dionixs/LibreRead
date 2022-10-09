# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :import
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags

  validates :title, presence: true, length: { minimum: 2 }
  validates :author, presence: true
  validates :place, presence: true
  validates :created_kindle_at, presence: true
  validates :clipping, presence: true

  # def self.tagged_with(title)
  #   Tag.find_by!(title:).notes
  # end
  #
  # def self.tag_counts
  #   Tag.select('tags.*, count(note_tags.tag_id) as count')
  #      .joins(:note_tags).group('note_tags.tag_id')
  # end
  #
  # def tag_list
  #   tags.map(&:name).join(', ')
  # end
  #
  # def tag_list=(titles)
  #   self.tags = titles.split(',').map do |n|
  #     Tag.where(name: n.strip).first_or_create!
  #   end
  # end
end
