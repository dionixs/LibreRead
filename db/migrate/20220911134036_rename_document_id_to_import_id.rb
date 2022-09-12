class RenameDocumentIdToImportId < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :document_id, :import_id
  end
end
