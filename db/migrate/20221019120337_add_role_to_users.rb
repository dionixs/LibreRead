# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def up
    safety_assured do
      execute <<-SQL.squish
      CREATE TYPE user_role AS ENUM ('admin', 'moderator', 'basic');
      SQL
      add_column :users, :role, :user_role, default: 'basic', null: false
    end
  end

  def down
    safety_assured do
      remove_column :users, :role
      execute <<-SQL.squish
      DROP TYPE user_role;
      SQL
    end
  end
end
