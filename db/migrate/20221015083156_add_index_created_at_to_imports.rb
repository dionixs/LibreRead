# frozen_string_literal: true

class AddIndexCreatedAtToImports < ActiveRecord::Migration[7.0]
  def change
    add_index :imports, :created_at
  end
end
