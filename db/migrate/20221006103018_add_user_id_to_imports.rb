# frozen_string_literal: true

class AddUserIdToImports < ActiveRecord::Migration[7.0]
  def change
    opts = { null: false, foreign_key: true }
    opts = opts.merge({ default: User.first.id }) if User.all.any?
    add_reference :imports, :user, **opts
  end
end
