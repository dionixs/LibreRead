# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do

    def self.tagged_with(tags:, import_id:)
      Note.where(import_id:).joins(:tags)
          .where(tags: { title: tags.split(',') })
    end

    def tag_list=(tags_string)
      tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
      new_or_found_tags = tag_names.collect { |title| Tag.find_or_create_by(title:, user_id:) }
      self.tags = new_or_found_tags
    end

    def tag_list
      Note.find_by(id:)&.tags&.map(&:title)&.join(',')
    end

    private

    def delete_all_tags
      tags.each(&:destroy)
    end
  end
end
