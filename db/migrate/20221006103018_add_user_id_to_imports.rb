# frozen_string_literal: true

class AddUserIdToImports < ActiveRecord::Migration[7.0]
  def change
    add_reference :imports, :user, null: false, foreign_key: true, default: User.first.id
  end
end
