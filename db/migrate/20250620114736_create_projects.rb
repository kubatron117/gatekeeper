class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, limit: 255, null: false
      t.text :description, limit: 2000

      t.timestamps
    end
  end
end
