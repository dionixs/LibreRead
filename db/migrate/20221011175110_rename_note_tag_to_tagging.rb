# frozen_string_literal: true

class RenameNoteTagToTagging < ActiveRecord::Migration[7.0]
  def change
    rename_table :note_tags, :taggings
  end
end
