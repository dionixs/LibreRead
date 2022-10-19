# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do

    def self.tagged_with(tags:, import_id:)
      Note.where(import_id:).joins(:tags)
          .where(tags: { title: tags.split(',') })
    end

    def all_tags=(titles)
      self.tags = titles.split(',').map do |title|
        Tag.where(title: title.strip, user_id:).first_or_create!
      end
    end

    def all_tags
      Note.find_by(id:)&.tags&.map(&:title)&.join(',')
    end

    private

    def delete_all_tags
      tags.each(&:destroy)
    end
  end
end
