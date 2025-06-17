class AddCascadeDeleteToTasksDocumentForeignKey < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :tasks, :documents
    add_foreign_key :tasks, :documents, on_delete: :cascade
  end
end
