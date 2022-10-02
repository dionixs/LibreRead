# frozen_string_literal: true

class AddPasswordMustBeChangedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_must_be_changed, :boolean, default: false
  end
end
