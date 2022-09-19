# frozen_string_literal: true

class RenameDocumentToImport < ActiveRecord::Migration[7.0]
  def change
    rename_table :documents, :imports
  end
end
