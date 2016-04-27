class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: false do |t|
      t.string :uuid, null: false
      t.string :title
      t.belongs_to :user

      t.timestamps null: false
    end
    add_index :projects, :uuid, unique: true
  end
end
