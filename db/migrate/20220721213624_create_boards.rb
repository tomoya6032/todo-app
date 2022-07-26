class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :user_id
      
      t.timestamps
    end
    add_index :posts, :user_id
    add_foreign_key :posts, :users
  end
end
