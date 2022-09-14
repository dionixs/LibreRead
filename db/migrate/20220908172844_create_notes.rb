class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.integer :place, null: false
      t.datetime :created_kindle_at, null: false
      t.text :clipping, null: false

      t.timestamps
    end
  end
end
