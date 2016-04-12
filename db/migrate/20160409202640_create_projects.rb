class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
