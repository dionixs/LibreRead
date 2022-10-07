# frozen_string_literal: true

class CreateNoteTags < ActiveRecord::Migration[7.0]
  def change
    create_table :note_tags do |t|
      t.belongs_to :note, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :note_tags, %i[note_id tag_id], unique: true
  end
end
