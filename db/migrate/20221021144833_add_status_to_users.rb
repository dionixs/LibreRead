# frozen_string_literal: true

class AddStatusToUsers < ActiveRecord::Migration[7.0]
  def up
    safety_assured do
      execute <<-SQL.squish
      CREATE TYPE user_status AS ENUM ('active', 'banned');
      SQL
      add_column :users, :status, :user_status, default: 'active', null: false
    end
  end

  def down
    safety_assured do
      remove_column :users, :status
      execute <<-SQL.squish
      DROP TYPE user_status;
      SQL
    end
  end
end
