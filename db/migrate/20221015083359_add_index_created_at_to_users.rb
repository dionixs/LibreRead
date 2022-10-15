# frozen_string_literal: true

class AddIndexCreatedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :created_at
  end
end
