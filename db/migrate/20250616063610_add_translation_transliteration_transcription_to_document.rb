class AddTranslationTransliterationTranscriptionToDocument < ActiveRecord::Migration[8.0]
  def change
    add_column :documents, :translation, :text
    add_column :documents, :transcription, :text
    add_column :documents, :transliteration, :text
  end
end
