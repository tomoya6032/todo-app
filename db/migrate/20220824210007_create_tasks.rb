class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false
      t.references :board, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :limit
      t.datetime :deadline_at
      t.timestamps
    end
  end
end
