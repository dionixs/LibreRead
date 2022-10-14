# frozen_string_literal: true

class AddIndexUserLowerEmailToUsers < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL.squish
      CREATE UNIQUE INDEX user_lower_email_idx ON users (LOWER(email));
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP INDEX user_lower_email_idx;
    SQL
  end
end
