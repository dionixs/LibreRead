# frozen_string_literal: true

class RemoveDefaultUserIdFromImportsNotes < ActiveRecord::Migration[7.0]
  def up
    change_column_default :imports, :user_id, from: User.first.id, to: nil
    change_column_default :notes, :user_id, from: User.first.id, to: nil
  end

  def down
    change_column_default :imports, :user_id, from: nil, to: User.first.id
    change_column_default :notes, :user_id, from: nil, to: User.first.id
  end
end
