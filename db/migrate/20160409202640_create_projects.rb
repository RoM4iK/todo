class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: false do |t|
      t.string :id, unique: true, index: true
      t.string :title
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
