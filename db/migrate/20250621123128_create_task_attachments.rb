class CreateTaskAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :task_attachments do |t|
      t.references :task, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
