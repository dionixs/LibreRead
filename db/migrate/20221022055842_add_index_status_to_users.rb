# frozen_string_literal: true

class AddIndexStatusToUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :users, :status, algorithm: :concurrently
  end
end
