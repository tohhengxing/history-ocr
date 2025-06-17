class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :document, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
