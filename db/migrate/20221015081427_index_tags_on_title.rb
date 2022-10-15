# frozen_string_literal: true

class IndexTagsOnTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :tags, :title
  end
end
