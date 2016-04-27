class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :uuid, null: false
      t.string :title
      t.boolean :completed
      t.datetime :deadline_at
      t.integer :position
      t.string :project_uuid, index: true

      t.timestamps null: false
    end
    add_index :tasks, :uuid, unique: true
  end
end
