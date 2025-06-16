class AddDetailsToDocuments < ActiveRecord::Migration[8.0]
  def change
    add_column :documents, :transcribed, :text
    add_column :documents, :translated, :text
    add_column :documents, :transliterated, :text
  end
end
