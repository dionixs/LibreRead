# frozen_string_literal: true

class AddPasswordResetTokenAndPasswordResetTokenSentAtToUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_column :users, :password_reset_token, :string
    add_index :users, :password_reset_token, algorithm: :concurrently
    add_column :users, :password_reset_token_sent_at, :datetime
  end
end
