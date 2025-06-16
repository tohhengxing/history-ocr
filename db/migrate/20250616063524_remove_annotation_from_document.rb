class RemoveAnnotationFromDocument < ActiveRecord::Migration[8.0]
  def change
    remove_column :documents, :annotation, :json
  end
end
