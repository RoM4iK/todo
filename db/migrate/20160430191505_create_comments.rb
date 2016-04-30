class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, id: false do |t|
      t.string :uuid, null: false
      t.text :text
      t.attachment :image
      t.belongs_to :user, index: true, foreign_key: true
      t.string :task_uuid, index: true
      t.timestamps null: false
    end
    add_index :projects, :uuid, unique: true
  end
end
