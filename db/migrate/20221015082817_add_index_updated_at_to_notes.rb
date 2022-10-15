# frozen_string_literal: true

class AddIndexUpdatedAtToNotes < ActiveRecord::Migration[7.0]
  def change
    add_index :notes, :updated_at
  end
end
