# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :import
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 2 }
  validates :author, presence: true
  validates :place, presence: true
  validates :created_kindle_at, presence: true
  validates :clipping, presence: true

  # TODO

  # def self.tagged_with(title)
  #   Tag.find_by!(title:).notes
  # end

  # def self.tag_counts
  #   Tag.select('tags.*, count(note_tags.tag_id) as count')
  #      .joins(:note_tags).group('note_tags.tag_id')
  # end

  # def tag_list(opt)
  #   tags.where(user_id: opt[:user_id]).map(&:title)
  # end
  #
  # def tag_list=(opt)
  #   self.tags = opt[:tags].split(',').map do |title|
  #     Tag.where(title: title.strip, user_id: opt[:user_id]).first_or_create!
  #   end
  # end
end
