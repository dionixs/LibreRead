class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :filename, null: false
      t.string :mime_type, null: false
      t.text :data, null: false

      t.timestamps
    end
  end
end
