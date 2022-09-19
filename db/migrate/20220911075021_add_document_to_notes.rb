# frozen_string_literal: true

class AddDocumentToNotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :notes, :document, null: false, foreign_key: true
  end
end
