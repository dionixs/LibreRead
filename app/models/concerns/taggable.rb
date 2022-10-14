# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do

    # todo
    def self.tagged_with(title:, import_id:)
      Tag.find_by!(title:).notes.where(import_id:)
    end

    def all_tags=(titles)
      self.tags = titles.split(',').map do |title|
        Tag.where(title: title.strip, user_id:).first_or_create!
      end
      # TODO
      update(updated_at: Time.current)
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
