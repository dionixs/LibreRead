# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do

    def all_tags=(titles)
      # TODO: Add update updated_at note if tag was created
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

  class_methods do
    # TODO: Refactoring
    def self.tagged_with(title, opt)
      Tag.find_by!(title:).notes
         .where(user_id: opt[:user_id])
    end
  end
end
