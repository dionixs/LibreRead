# frozen_string_literal: true

class Note < ApplicationRecord
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

  # TODO: Create concern
  #
  def all_tags=(titles)
    # Add update updated_at note if tag was created
    self.tags = titles.split(',').map do |title|
      Tag.where(title: title.strip, user_id:).first_or_create!
    end
  end

  def all_tags
    Note.find_by(id:)&.tags&.map(&:title)&.join(',')
  end

  def self.tagged_with(title, opt)
    Tag.find_by!(title:).notes
       .where(user_id: opt[:user_id])
  end

  private

  def delete_all_tags
    tags.each(&:destroy)
  end
end
