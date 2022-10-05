# frozen_string_literal: true

class AddDocumentToNotes < ActiveRecord::Migration[7.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_reference :notes, :document, null: false, foreign_key: true
    # rubocop:enable Rails/NotNullColumn
  end
end
