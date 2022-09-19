# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :mime_type
      t.text :data

      t.timestamps
    end
  end
end
