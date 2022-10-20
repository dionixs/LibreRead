# frozen_string_literal: true

class AddIndexToUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :users, :role, algorithm: :concurrently
  end
end
