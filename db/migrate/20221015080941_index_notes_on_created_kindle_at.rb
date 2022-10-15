# frozen_string_literal: true

class IndexNotesOnCreatedKindleAt < ActiveRecord::Migration[7.0]
  def change
    add_index :notes, :created_kindle_at
  end
end
