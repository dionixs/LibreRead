class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :author
      t.integer :place
      t.datetime :created_kindle_at
      t.text :clipping

      t.timestamps
    end
  end
end
