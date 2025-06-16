class RemoveMoreDetailsFromDocuments < ActiveRecord::Migration[8.0]
  def change
    remove_column :documents, :transcription, :text
    remove_column :documents, :translation, :text
    remove_column :documents, :transliteration, :text
  end
end
