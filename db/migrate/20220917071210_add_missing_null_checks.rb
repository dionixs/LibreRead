# frozen_string_literal: true

class AddMissingNullChecks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :imports, :filename, false
    change_column_null :imports, :mime_type, false
    change_column_null :imports, :data, false
    change_column_null :notes, :title, false
    change_column_null :notes, :author, false
    change_column_null :notes, :place, false
    change_column_null :notes, :created_kindle_at, false
    change_column_null :notes, :clipping, false
  end
end
