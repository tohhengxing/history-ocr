class RemoveDetailsFromDocuments < ActiveRecord::Migration[8.0]
  def change
    remove_column :documents, :transcribed, :text
    remove_column :documents, :translated, :text
    remove_column :documents, :transliterated, :text
  end
end
